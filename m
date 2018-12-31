Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73692C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:35:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384B721720
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kTUpFUIp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="D3w8BkUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384B721720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QfW5XES9nUTAYusqBEc/PNeb8iu5G68SEaoBgvpVliU=; b=kTUpFUIpx8QsAD
	UEBu/5sJ7utT6n3vrWJLEfAaZwcNR9CxZgPXgtIIfFbZfa8lNdu4rvYli5kJ3dkgpasvnwlIQSyCz
	OvZ1/3cGFZSp/w0gW32leA5qc/1CnNYiHTdfWsSvYACdrHNkKLqIKnNd/ls7hdnKEZJXB3Doo/6+h
	62Yrk9E6dackYkSehK7D8OfVve/7eN9ID3cPtm8iEBrgKF6Ds8Kyy4qBxDZgiwqDqOwjHBVlGu5QA
	Vn7v5b7KS4UmvLEwX7PmiVMwe7MtdydLyvfE3LXow6CbwWufWbxiXienpueL4AraSKFZeK9NpB2cO
	SRiKf2nIfqLKLNkfR9aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge5DX-0007J4-Vi; Mon, 31 Dec 2018 21:35:24 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge5Cz-0005l3-SW
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 21:34:52 +0000
Received: by mail-lf1-x144.google.com with SMTP id u18so18840362lff.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 13:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=f7ekWYqy5/KTumZqr5dhtGpNMgtrKB2/mXlF00ljUuw=;
 b=D3w8BkUZn/F3BSbpPqF5pOccBzomDqSYWsjuaHwVvxiwmMiuQncd8jW857YBjyuX+3
 fmX2KqDD8wGdYJI6g1dEPIyzQJWAYphqnyxfZ5dNKSWq1M2y1yGc58WglKtU9SAQ97+c
 UCs19wBt5NdwfQAuDnYbEcSzqvBu3eLaDczasK+/I0czAbnLd/eF0il8K8GxIQgQ19Ub
 VO9Vi5Pr/cdFrLHfYHfXkt0qRL7FbAazznBMbMrCeOglz/LnpUs7hlGBedBgG3pBT+hv
 V2RM5/hwuwSlVgQwq/K+zCoQa6b5mHroZhvcusBHSUJa5OqSMztXDK5/gkLUuYgwaTm7
 bc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=f7ekWYqy5/KTumZqr5dhtGpNMgtrKB2/mXlF00ljUuw=;
 b=JZPmreOHhDAaCLvYwrxdQC52SyjrrRlCY68cKfEaPjFSdBsmRToHPHtyoFxd4If90x
 oVeboiXh+O9UThJkhvsR8GJ/aEeje4Y1/KXMhVOPMcVgTOQ0xAp/KAdnTj1rNnR/Ch+J
 Iww4UOAQwQsFPxFIM4/ufU8FU9w2qkEUAo3r34Wtl3IsjJiwZ789dOWyoagdP/ck+ETN
 qpBpnMidm/b4JZfJOoDwTFsw+eVCTyGXMXDAUw5JECdJkxyY47/9b52mupsOi/QcixyW
 WBeLUUqvwX0CikKUbEeNkiJJ7zvV4BHi54ZpqMd3Dm78YIbSABO+DQI24RMdMGdz9+OR
 IacA==
X-Gm-Message-State: AA+aEWZg6j/0+OrpW1RoKxMd87LlojjHaEkLW24MaxfJO+EMposJuOVn
 oucDDG6V/WwjSlVyIq475xTypQ==
X-Google-Smtp-Source: AFSGD/XiM4gr+YlIsFu1cLG0Jhz2Kwm2YOvsmLVfFJHX0FwP5IzmZ8meBbnrSwmxU+qmuufK/S5zOA==
X-Received: by 2002:a19:a086:: with SMTP id j128mr18090675lfe.93.1546292088168; 
 Mon, 31 Dec 2018 13:34:48 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id u11sm9509341lfb.85.2018.12.31.13.34.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 31 Dec 2018 13:34:47 -0800 (PST)
Date: Mon, 31 Dec 2018 13:10:50 -0800
From: Olof Johansson <olof@lixom.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL 1/2] ARM: dts: exynos: Second round for v4.21
Message-ID: <20181231211050.wlcmsppq44tbhf7n@localhost>
References: <20181218201003.12806-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218201003.12806-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_133449_930352_D790A222 
X-CRM114-Status: GOOD (  15.55  )
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

On Tue, Dec 18, 2018 at 09:10:02PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> On top of previous pull request.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 57b13b8b34002ce8f1d822ea05f0a84e5bc3a64a:
> 
>   ARM: dts: exynos: remove display-port node from Arndale (2018-12-06 19:47:15 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.21-2
> 
> for you to fetch changes up to 8ac686d7dfed721102860ff2571e6b9f529ae81a:
> 
>   ARM: dts: exynos: Specify I2S assigned clocks in proper node (2018-12-13 21:56:07 +0100)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v4.21, part 2
> 
> 1. Add missing CPUs in cooling maps for Odroid X2 (missed in previous
>    round of fixups).
> 2. Fix clock configuration in audio subsystem on Odroid XU3/XU4.

Merged into next/late. Will try to merge this window, best-effort.


-Olof


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
