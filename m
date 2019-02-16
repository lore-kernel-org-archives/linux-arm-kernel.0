Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8116AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:21:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E7721A4C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g+h8LXWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E7721A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4diOg+gMUR6fPbo/qYecXv4scOqEw8vkAtpqnii9wHc=; b=g+h8LXWgx5syrp
	GwsXqt5RSdlG0y2VtEgfiWaX6umJhYxunwl1WKK6s5RmaQZgzD71zT+9HlLCP3djkBuEP8Pm2/t9o
	bxbTsS3pkAs2nDreBng7wV7LC4ZUopPMELN1q7MPf53sdV6Dv9Kfp67iDDM0ohD+f0rXm+gyLb7nM
	m52YojYdc1KDoFnVmnJxBte33cM8uit6l2suXDf8QlxcZIqQ46pWyaMsSYwWe85aeHJW9UtZakK5S
	sqzHc3f3mrkO0VMNkXMmoVIwum/vG2a2sI/Yg6ekKf3PSDLHlRDYuZ+Wvv1cX2QVr13cgioGejhzi
	EZ+UzROD+fmRfy+RqOPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv6SV-0007xi-9P; Sat, 16 Feb 2019 20:21:11 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv6SR-0007wZ-5Z
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 20:21:08 +0000
Received: by mail-qt1-f194.google.com with SMTP id v10so14972102qtp.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 16 Feb 2019 12:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=OAYI86GP7FBxDrkNOtDB+j4T8A5VXyFEaWAq+fHWQ0k=;
 b=NjsnRcUpjjp5bnIqSw/Ic1auTII2KyS8a2GbuGAiupKXa+WlurJhTkxEdK0DSL5VLW
 mBiz/DRfFtNjR3ilD0a3GQEDg4XARLrRLsf4JPe7lIc8/kokPa9MxKGlB3HkBoJKqi97
 b9qeSEpvttxe3y4s/kEUHG7NWVVguOKrUKci/yqLlyxc9iS4XttTsHFoZy0y1SBS/EDr
 EFkHSMj56WDxUOQRbOqk5nrxtejCzgbe40SUJddLbd+JJAzBli9KNqxTb/oZlCRiX+gY
 kijFbUEWev0pAkXR+M6060KAJsxVYs0gPAkRziANbWYmasod9Gfw4S4pAtN6/V6fx4Sa
 8zow==
X-Gm-Message-State: AHQUAubyWAZvGEw1ghnOvGVrNJXbzCG5dP/gzrTVBR98FF5q5iZ4Xr3W
 kepDMv45cviVauCpJ43JSsI4zOzsrmNz2+OUOR4=
X-Google-Smtp-Source: AHgI3Ia/2rsWZ8K/2zWyynt4pkoPhVdkNlUkukzVf6+l9kZ2DcdzJfacPmVF8o7JBsFlpp7UcyJdnPYTp0KubJa/xKs=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr11897047qve.180.1550348465878; 
 Sat, 16 Feb 2019 12:21:05 -0800 (PST)
MIME-Version: 1.0
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 16 Feb 2019 21:20:48 +0100
Message-ID: <CAK8P3a1d4VMFCOq=G_Qwcoof=eXQK75TCewDMWb_tRda+EQoPw@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for 5.0
To: Linus Torvalds <torvalds@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_122107_210787_72C19233 
X-CRM114-Status: GOOD (  12.43  )
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
Cc: soc@kernel.org, arm-soc <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 410d7360541c0e21b58e56b64e5bcdbec9c1d285:

  Merge tag 'omap-for-v5.0/fixes-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
arm/fixes (2019-02-15 20:39:46 +0100)

----------------------------------------------------------------
This week is a much smaller update, containing fixes only for TI OMAP,
NXP i.MX and Rockchips platforms:

 - omap4 had problems with lost timer interrupts
 - another IRQ handling issue with OMAP5
 - A workaround for a regression in the pwm-omap-dmtimer driver

 - eMMC was broken on the new imx8mq-evk board

 - a fix for new dtc graph warnings and a regulator fix for rock64
 - USB support broke on rk3328-rock64

----------------------------------------------------------------
Arnd Bergmann (5):
      Merge tag 'omap-for-v5.0/fixes-rc4' of
git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'v5.0-rockchip-dts32fixes-1' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/fixes
      Merge tag 'v5.0-rockchip-dts64fixes-1' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/fixes
      Merge tag 'imx-fixes-5.0-3' of
git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'omap-for-v5.0/fixes-rc5' of
git://git.kernel.org/.../tmlind/linux-omap into arm/fixes

Carlo Caione (1):
      arm64: dts: imx8mq: Fix boot from eMMC

Dmitry Voytik (1):
      arm64: dts: rockchip: enable usb-host regulators at boot on rk3328-rock64

Enric Balletbo i Serra (1):
      arm64: dts: rockchip: fix graph_port warning on rk3399 bob kevin
and excavator

Johan Jonker (1):
      ARM: dts: rockchip: remove qos_cif1 from rk3188 power-domain

Russell King (1):
      ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug

Tony Lindgren (5):
      clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting
      ARM: OMAP5+: Fix inverted nirq pin interrupts with irq_set_type
      bus: ti-sysc: Fix timer handling with drop pm_runtime_irq_safe()
      ARM: dts: Configure clock parent for pwm vibra
      Merge branch 'pwm-dmtimer-fixes' into omap-for-v5.0/fixes-v2

Yizhuo (1):
      ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads()
could be uninitialized

 arch/arm/boot/dts/omap4-droid4-xt894.dts           | 11 ++++++
 arch/arm/boot/dts/omap5-board-common.dtsi          |  9 +++--
 arch/arm/boot/dts/omap5-cm-t54.dts                 | 12 +++++-
 arch/arm/boot/dts/rk3188.dtsi                      |  1 -
 arch/arm/mach-omap2/cpuidle44xx.c                  | 16 ++------
 arch/arm/mach-omap2/display.c                      |  7 +++-
 arch/arm/mach-omap2/omap-wakeupgen.c               | 36 +++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts       | 44 +++++++++++-----------
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |  2 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |  2 +
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts    |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  2 +-
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |  2 +-
 drivers/bus/ti-sysc.c                              |  6 +--
 drivers/clocksource/timer-ti-dm.c                  |  5 ++-
 15 files changed, 109 insertions(+), 48 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
