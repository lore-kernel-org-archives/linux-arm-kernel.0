Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B654AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:36:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7916321720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fu40wQCG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="s0oTUVTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7916321720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+hO1j3GG5Ek95bCXB51+qoxb6cRRuAl+ad4TGVXQ/I0=; b=Fu40wQCGbkg7rM
	EhuuZlvC9HfV19yYOUBhZTX5NCDqap2lSVcNEaj+FdQOEImxGUCnGWz6svdQfrUXQ5G3fi9QmZxRP
	PPUGu2EB9EjqwL2dw0gSnnYg1wT/5+5/GQlLwhMBBRx063CcOpTj5kzIvXIqjzn2PgFVbGlzyVQQT
	qh02m8r3S5iwZd+aiMGIH/kiG7/JKIVGSfjMCauzrSaE+MR5nVtQVib6E3Hzps69rKeSMdblDeNY3
	88PHyaj7yC1UxZlLKYjoFVyM/NgBFCC73tIYNQTy9uOPish7UC8aXZVeQVlRL9sF7zmwzciEEuCY6
	FxAv3xYZW4zDFF4n9R8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge5E6-0007yB-9f; Mon, 31 Dec 2018 21:35:58 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge5D1-0005lu-S9
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 21:34:53 +0000
Received: by mail-lj1-x244.google.com with SMTP id s5-v6so24272060ljd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 13:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6lLcK8xprX6a7/hE9IcLFZK8c7AsFCfb5lOkKsasDws=;
 b=s0oTUVTdvwLVhCGnhUD8UIcV86XqWiJD1aouCZxnqJGk4UdL1Z5SmIesvu5c+8M0/D
 g69Ssmt9p5PnOfcYnLjl9PXBfzzPm/L7sIk86e1ifBeo75q3hJTzHfYuPTR4Rshxqy3m
 eVOldIUdlEgxDS2ZK7Ozuj4iT3vlOrOd4JJekXfS9B2kUC398vMb72pb1Mgmv/3y09q/
 Ysj6Fu2pwpI8zaLT/vg7DDxKSCI8wR3FwN6vgdTnJmz8RdaQC96EjzvdbaN79Jnrq0ea
 JqLKTcDIXiC5og8e1Uy/8cSpUTqtnMBXLLj2QHgooArMp92iqbjl6I7VRzJ2if8iWScf
 B5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6lLcK8xprX6a7/hE9IcLFZK8c7AsFCfb5lOkKsasDws=;
 b=CZylw1B5lSUNrfnin6su0cXWCvauDTk7yB5OD+qrygYU4NDF1hvoSAHuhWvRF5SlDi
 Btxo/+HsLoA2PX3NNgd/yHgwAp6GsMTHcjy/7fQclBnfIaNQuWf5w+ZlLcLqW+Vj5WLR
 z8RgGVyjkXFV/a/3aBFs4Ztg2w7QguHjgjJUhVTdI6b05xdrCjEgQIzwcBy9MoNVYrIP
 eOjBoZciQUi2aR2WuI8WsyDz41zGgV6j89jNllFEoBWaGx4QOLIrWWsG0Wc8PbolU08P
 zYxvgCl/B9fBkO89h8le/mzH8bsAWN0ia5Cs3d2ViCJh74FgB/BbCkBRbmGhICN/BhuV
 jwbg==
X-Gm-Message-State: AJcUuke4QfRxp4kpoPRyFdz2xeeyunUCCRJqXx9KqwFJQQsBUtCHnYFq
 Bkml6cq0vOapXcSee1PAHqHcNQ==
X-Google-Smtp-Source: ALg8bN7aXNZ0eQGDqM4H3o3kTT3TGzjPJfW6nZd/rPPn0UyYc2fRML6eGbCybJ3QU4ncAFt6afU18g==
X-Received: by 2002:a2e:2d4:: with SMTP id
 y81-v6mr22109373lje.62.1546292090298; 
 Mon, 31 Dec 2018 13:34:50 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id b17-v6sm10423335ljj.93.2018.12.31.13.34.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 31 Dec 2018 13:34:49 -0800 (PST)
Date: Mon, 31 Dec 2018 13:11:22 -0800
From: Olof Johansson <olof@lixom.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL 2/2] arm64: dts: exynos: Second round for v4.21
Message-ID: <20181231211122.7itlvetzx3tpuua6@localhost>
References: <20181218201003.12806-1-krzk@kernel.org>
 <20181218201003.12806-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218201003.12806-2-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_133451_907577_C19D84C1 
X-CRM114-Status: GOOD (  14.52  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, arm@kernel.org, Kukjin Kim <kgene@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 09:10:03PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> On top of previous pull request.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 9deffb5ee78e41e2a5d6c448874a24caec6467d0:
> 
>   arm64: dts: exynos: Add all CPUs in cooling maps (2018-11-18 15:18:42 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-4.21-2
> 
> for you to fetch changes up to 74ebbdda7cecf789661c208faccbeef10a7f05da:
> 
>   arm64: dts: exynos: Add Bluetooth chip to TM2(e) boards (2018-12-17 20:23:32 +0100)

Merged into next/late.


Thanks,

-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
