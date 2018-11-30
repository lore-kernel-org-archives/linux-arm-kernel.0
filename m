Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FABC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:58:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A187020834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HSVjmpqT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="di4QIGrA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A187020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rZeakCfFL6Kj+TEr411p3fOKOx6Mqlg2ChkksIqHbE8=; b=HSVjmpqTsdoda/
	NwQEgKbV20YZNxvvLkuFuKK0qg2AajWTCWVbr7jYQM3kiIdIoYCZ0He3T5oNVdoLV0SHq5OpXDM7M
	k96eiT4jVpMTsZkUGq47E9h/s4v/3byGoiSnLO1dhCiktz8vaGyA3p8mr1+1/qksQanK73T2qZR8j
	UPIKOnZNDKpmGe72Tf2IXaopGxoA8LXwVA0f+Sx8E8ijFUj/2jYOO0GDNxfV34hYWRF7YtzXXfzBX
	b9e4Cna1vBFYHDoRjYqdcEUPWFuR5GlYHQs/hbtG0eKqfne0OLwhg2Z45l8Hcmr1nUBjDcBhzKDs+
	bydVLmJyM2rwNErtoU4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSrkK-0005bz-4R; Fri, 30 Nov 2018 22:58:52 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSriE-0003vb-Tn
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 22:56:47 +0000
Received: by mail-lj1-x242.google.com with SMTP id e5-v6so6412671lja.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 14:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AKRHMvfcYb8XZZUwHuLgoWGLfiCuQPlbo6tt3WpIHD8=;
 b=di4QIGrA8MGutd/1uwlEzZRaJNE5dxviLI+ZeZylTTj45MxhZkBel9Dp89SDW5BXMP
 UNBXiNYniqq62apsWUET6xgIAH1oUrNvGFYFyJeDayzTWSj0OTSh9uWTnDTqbo48XNCy
 IBLDmeKLCxe0+vYqxXYG4uRdPrxTe6iPnQ+hi3MRK1E1Cr9dXW1yTwAgKvUzrf4wSAvd
 hWOS3EmT4dbyfediS5IoxDq2vliQFQLNuIqr6rS+xcDitf50iu+rfHkXME+7uLc+xXTA
 P2XI6/cfPYuu4RjHeeHyjx/gHuEixKkoFNkur6Px+/oFlFo6AMAmXInQSXLWdPpvexqZ
 1cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AKRHMvfcYb8XZZUwHuLgoWGLfiCuQPlbo6tt3WpIHD8=;
 b=ov5XGvoR9Ei/1ek5JmgHODy71P+1aNtTv8k9UwBnJ/unqLEa//yaacbgLrQum3A3Rq
 B0M5VsAnkZcET8W9or8ldM1kMUku4DkaiQdRI9mjEQ80Eis57tZ5susQwkJiUX+OpZFB
 7T/X3Q3L6T/NzdscdHmnEMA5/FvvvePFR9PVM33UmQwWtC1ACcRQiVChoNKz2vZx16Nc
 +lWZiakSAuC8NYkg9ewA7kI7907jt3T72WoN/kV9HuvexCpbgq/FhU1D1R+InUZr4fta
 YQ9pUfFmCEBAqADwZeXPgWooRhGqQFfe743oFFdNJ8vmNFCzXfcepKSXzHzDdbJ9Li65
 MDIg==
X-Gm-Message-State: AA+aEWYlfIpifewMqFmKSDfg9PVMHRuFlXuzV1pTcywIgbIpHXos6H8E
 lrigI2dRqYtWsur6a0gg7JAAQg==
X-Google-Smtp-Source: AFSGD/VRg034JU/wkiBm1GoEcnRNVEPJ7ANqAohmKDNtBMK/OJesqqeylT/zMAslUTZdFOYmS2yq0w==
X-Received: by 2002:a2e:9e95:: with SMTP id
 f21-v6mr4957135ljk.128.1543618590602; 
 Fri, 30 Nov 2018 14:56:30 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id c20sm1011414lfj.67.2018.11.30.14.56.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 14:56:29 -0800 (PST)
Date: Fri, 30 Nov 2018 11:50:27 -0800
From: Olof Johansson <olof@lixom.net>
To: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [GIT PULL 2/2] Rockchip arm64 devicetree fixes for 4.20
Message-ID: <20181130195027.yimshus5hz2wjw6m@localhost>
References: <110221357.jpgQ0Qy0za@phil>
 <3222605.xbTO2UFBUd@phil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3222605.xbTO2UFBUd@phil>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_145643_594337_FFF94D90 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: linux-rockchip@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 22, 2018 at 01:32:42PM +0100, Heiko Stuebner wrote:
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.20-rockchip-dts64fixes-1
> 
> for you to fetch changes up to c1d91f86a1b4c9c05854d59c6a0abd5d0f75b849:
> 
>   arm64: dts: rockchip: Fix PCIe reset polarity for rk3399-puma-haikou. (2018-11-13 15:02:07 +0100)

Merged, thanks.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
