Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74FCC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:58:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9126D2190C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rz9iodhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9126D2190C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TCZOFcn9kGIAC68Pe1iaepx5nwDMprNUzaq6QLLcc+8=; b=rz9iodhr9SCDiN
	ZnncuJDLxwDyBZxeoGcQ9K0J9qhrnOgRa+tTJ6S4rM/Veenl5xovLeeSGpFsbXM8LjDVBmqNGiDmq
	JvSBg7aH5rLI1G4ES28BkGGDPRtebmo1HnB52Jd5HwS/zOZj2VVGaMzTZL0hGHhjkZWl56tjs3/Rk
	7VWmIdd2E0sr5lM8Y6UvFZX9KG/FcDNFf8b+QYuvjQLB5CHEYpko1TFPsO2azGC8Uc7b8s7GHsoPr
	Je6xw07KgclHYW6f4NFvkzlqhczF9CTipELIkb+D0d8f2LqAllcKBQzv6jtxIV7FDZB4amR20bsqJ
	y13XDRHCiDYEXeaMzqfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufsQ-0001IY-76; Fri, 15 Feb 2019 15:58:10 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufsM-0001G3-4k
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:58:08 +0000
Received: by mail-qt1-f194.google.com with SMTP id n32so11324756qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 07:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VSgpvSHbN2I+ELNen9/yU6/QBu2aY3v4eYm8yESkzIY=;
 b=AtUiJW6xGqie706Pi+MajW4MfM3zpqsFnaj90icH5YZtsRShH6SjAGTaG+E1hDUCvq
 ew1nGDjL3B1qiYFuSoFECgenlKfWORW+8L4sz7o1Cdvjl4dvI7ZJOSfYrsbtvMpxWG/e
 MSiLNEPlrp4/nW1KvZKB1WJeg2GGYSAUrkeh/p0uWh4/3iy+nBPsJk2S6fGn/yomWVxo
 orwnYysHvYYnCdmIDMvYLx9/Q+wsgC6ESixT1h865M1aZwZkWpzyol18B+ptlvoyhSHt
 dVZOPXyk6i8ZzyqJNuyJ0TPOSl8KKEYb85HwwNqDm6y1XcdqgOrNAiskI1q5TUML+0PT
 g93w==
X-Gm-Message-State: AHQUAuaKlGrsiuMHf6Px1beyynqkV5gGvNoY433/bTlRMcYP6poln48o
 zmOLKoG229/LHJoLhbYuUW/EYnyxGEdcLDHNt3c=
X-Google-Smtp-Source: AHgI3IYQZpBnhNJ4k6p9tViBBkg5qZWmxmSaxvxzoo468Fg9zff/i57osIyJKMMVsT4r7q22NL0J8NEVRc7DN47mxik=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr7961020qtb.319.1550246285242; 
 Fri, 15 Feb 2019 07:58:05 -0800 (PST)
MIME-Version: 1.0
References: <20190203212936.17053-1-vz@mleia.com>
In-Reply-To: <20190203212936.17053-1-vz@mleia.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 16:57:48 +0100
Message-ID: <CAK8P3a3W=ozjmAWjVXHnjnxE8gs9zD9_gd=3VB_sTyCp4GLx0Q@mail.gmail.com>
Subject: Re: [GIT PULL 1/3] ARM: defconfig: NXP LPC32xx and LPC18xx/LPC43xx
 changes for 5.1
To: Vladimir Zapolskiy <vz@mleia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_075806_179205_0A3D7FC0 
X-CRM114-Status: GOOD (  18.59  )
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
Cc: Kevin Hilman <khilman@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>, arm-soc <arm@kernel.org>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>, Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, Feb 3, 2019 at 10:29 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
>
> Hi Arnd, Olof and Kevin,
>
> please consider to pull the updates to NXP LPC32xx and NXP LPC18xx/LPC32xx
> defconfig files, both defconfigs are now up to date to provide support of
> boards maintained in the Linux kernel and savedefconfig does not produce
> a difference.
>
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/vzapolskiy/linux-lpc32xx tags/lpc32xx-defconfig-for-5.1
>
> for you to fetch changes up to 25dc2e0bd22ecf7be552c44a71c0abe68f6a641d:
>
>   ARM: defconfig: lpc32xx: enable DRM simple panel driver (2019-02-03 21:25:42 +0200)
>
> ----------------------------------------------------------------
> ARM: lpc32xx: defconfig updates for v5.1
>
> Here are the changes for ARM NXP LPC32xx and ARM NXP LPC18xx/LPC43xx
> defconfig files:
> * LPC18xx/LPC43xx and LPC32xx defconfig files got updates to match
>   savedefconfig,
> * PL11x LCD controller driver on both LPC18xx/LPC43xx and LPC32xx
>   has been switched from fbdev to DRM one,
> * drivers of GPIO controllers not found on LPC32xx boards are disabled,
> * LPC32xx gets enabled additional sane debugging options: panic on oops,
>   sysrq, dynamic debug, timestamps in kernel log buffer and built GDB
>   scripts,
> * LPC32xx gets enabled NFSv4 support,
> * LPC32xx gets enabled a number of used drivers: DRM simple panel,
>   fixed voltage regulator and generic SRAM drivers,
> * Option to have a serial console on HS UART on LPC32xx is enabled.

Pulled into arm/defconfig. It took me a bit of time to check that the refreshing
of the defconfigs did not have any side-effects that went unnoticed. It's better
to split those up further into patches that either only move around
options, or drop options with explanations of what happened.

For the newly added options, I wouldn't mind doing the reverse and enabling
everything at once with the combined changelog.

Thanks,


      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
