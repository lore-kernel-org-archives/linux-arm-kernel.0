Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50162C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:24:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 150DE2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KHhfXIfn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="M+EvPVql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150DE2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WdbE6IetnHGrKPY4LYkZkTWhcudbJoa1ny9YecrggLM=; b=KHhfXIfnJguVnP
	CpCfOg+BBYlTMTYMDizjkSgojTmb2IIRiZqQMBcBDWHYSYl1tD0KYQz8cyeoDjGxHoSIcHVrWY9o7
	Bn52xejDahN6Sou569K4nnq83awW37PVpguT9bCOFtm89wwPN+xvqG+3IufNsWrpoujvfK86QQfSB
	oe2AC/v8QdCR6MQQJcf5Q6KZ5xtayGXETNTdsI4tkMFF+wnUdvK65I1LUHroLy7VC6oL2NKZzlZVf
	ll6OOWNuzp5YGtUJMK7WZSFOTU21AqogNoEoVvW8ifoG5kfWxDAjtL7IeFwaUMZfmxzmWkgwUhTt0
	9wCnJF+D6R6tfe1YpAYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWAJU-0000MH-8h; Mon, 10 Dec 2018 01:24:48 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWAIm-00086h-NL
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 01:24:09 +0000
Received: by mail-lj1-x243.google.com with SMTP id c19-v6so8101034lja.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 17:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=t/UBLbdynFhlbFxqKQdNUI6XlqKT8uSedEKVSAFRuYw=;
 b=M+EvPVql2IFAZHpmIgC+srA2Ar4e6TE5urPh8b9VIwzYX+mVUzTT3YKtKA8w/kZmJG
 NVYEOyEVmubFU63Qk1rwCNbZsKphdG4wc0mPkCcENdKESCAV42jHAsHJ7x9Q5xamvq0K
 P4ZBN2SpuUmezkfSRdgTVX3Vrh+PeRa0INog80+59/YGLDFSHkqTwkn1IvdCUTh5cmk1
 SP6J6cnJwhBlSF71TfPtpxC0Q50YKffd7EqaQKXT03XxvxRtO6qYQTUHR6mDqaGg5E3T
 He8rQ6gttZaKsHBoM4rjnt8zo/7iFN3KaTb74xZUn/EHUI2jgzuJAY4ySwYSu6cFCMeX
 7xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=t/UBLbdynFhlbFxqKQdNUI6XlqKT8uSedEKVSAFRuYw=;
 b=Bi4luApf034Rj85kc0ky6o3vvDPozx0ITrMmovdu9g+vS75oVB5bcJODEzrJ0LIFAD
 C6rhwrJYUw5SUOaJLvt0robmqLaNr1CkOM23MlAvXYuBNtD9W3A8IfkOGrgaQS27WaTZ
 6Aj2xidtSdCDKYz8JX7ePjdRkwrll4KombF63rZ2aP0tRUEX3DEnAhtphtTMu5jkruqk
 ctZ4Mb1NgaAEud4XHn23FLHTVpFnZbAc6s1mOnhKirvphcHggxDUXukevgKzZa/OWa7Q
 07e4OUefNFBnBAVPJUShHxB0EnBOQdlSGnVlfp9IccWbXecsfFaG6UaMx3VyDfOqR/ao
 2dtw==
X-Gm-Message-State: AA+aEWaz50+5MfzxnFQbNn8G3ZtfonbLAU/GhkjpqwOesFwyah/6w32u
 w1oOA5EsVlSLhhe9NQiGBtrIPQ==
X-Google-Smtp-Source: AFSGD/VCUuybhWj6sw1YX0xk0ZBQ6d9BNsTGliJqilFbL47+nBvrcbndU6cGHCIxiaqMw5XTFoePqQ==
X-Received: by 2002:a2e:2e1a:: with SMTP id u26-v6mr6519576lju.8.1544405032697; 
 Sun, 09 Dec 2018 17:23:52 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
 by smtp.gmail.com with ESMTPSA id c88-v6sm1885646ljf.60.2018.12.09.17.23.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 17:23:51 -0800 (PST)
Date: Sun, 9 Dec 2018 17:23:35 -0800
From: Olof Johansson <olof@lixom.net>
To: torvalds@linux-foundation.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20181210012335.jmxsw4yyj66lrbsp@localhost>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_172405_241511_DDBA71F8 
X-CRM114-Status: GOOD (  14.96  )
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
Cc: olof@lixom.net, arm@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Linus,


The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 0603a9a84679eb12d9dadb97f4e0ba017e684c7b:

  Merge tag 'mvebu-fixes-4.20-1' of git://git.infradead.org/linux-mvebu into fixes (2018-12-09 10:28:02 -0800)

----------------------------------------------------------------
ARM: SoC fixes

The usual batch; most of them are DT tweaks to fix misdescribed
hardware. Beyond that:

 - A bugfix for MMP2 CPU detection, it's been there quite a while but
   makes sense to fix now anyway.
 - Some power management tweaks;
   + disabling of CPU idle power state on Marvell Armada 7K/8K (Macchiatobin et al)
   + Increase of minimum voltage on BananaPi M3
   + Tweak of power ramp time for DVFS on NXP/Freescale i.MX7SX
 - A couple of MAINTAINER updates; MMP has a new volunteer to look after
   it, and Mediatek adds a few keywords, IRC channel and wiki URL.

----------------------------------------------------------------
Anson Huang (1):
      ARM: imx: update the cpu power up timing setting on i.mx6sx

Baruch Siach (1):
      Revert "arm64: dts: marvell: add CPU Idle power state support on Armada 7K/8K"

Corentin Labbe (1):
      ARM: dts: sun8i: a83t: bananapi-m3: increase vcc-pd voltage to 3.3V

Fabio Estevam (2):
      ARM: dts: imx7d-pico: Describe the Wifi clock
      ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock

Lubomir Rintel (2):
      ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt
      MAINTAINERS: update entry for MMP platform

Matthias Brugger (1):
      MAINTAINERS: mediatek: Update SoC entry

Olof Johansson (5):
      Merge tag 'v4.19-next-fixes' of https://git.kernel.org/.../matthias.bgg/linux into fixes
      Merge tag 'arm-soc/for-4.20/devicetree-fixes' of https://github.com/Broadcom/stblinux into fixes
      Merge tag 'imx-fixes-4.20-3' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'sunxi-fixes-for-4.20' of https://git.kernel.org/.../sunxi/linux into fixes
      Merge tag 'mvebu-fixes-4.20-1' of git://git.infradead.org/linux-mvebu into fixes

Rob Herring (1):
      ARM: dts: realview: Fix some more duplicate regulator nodes

Ryder Lee (3):
      arm64: dts: mt7622: fix no more console output on rfb1
      arm64: dts: mt7622: fix no more console output on BPI-R64 board
      arm64: dts: mt7622: Drop the general purpose timer node

Stefan Wahren (1):
      ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs

 CREDITS                                            |  8 +++++++
 MAINTAINERS                                        | 11 +++++----
 arch/arm/boot/dts/arm-realview-pb1176.dts          |  4 ++--
 arch/arm/boot/dts/arm-realview-pb11mp.dts          |  4 ++--
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |  2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |  9 ++++++--
 arch/arm/boot/dts/imx7d-pico.dtsi                  | 22 +++++++++++++++++-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |  4 ++--
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |  2 +-
 arch/arm/mach-mmp/cputype.h                        |  6 +++--
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |  4 ----
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 27 ----------------------
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |  7 +++++-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |  7 +++++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           | 10 --------
 16 files changed, 67 insertions(+), 62 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
