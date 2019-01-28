Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300D6C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:03:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18202148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W+B9Y2eV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Nq5C+wnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18202148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7DW4/7ym4tEKMo+1BiA8dw3bs1WOufU3/CrRiNlbv6g=; b=W+B9Y2eVkm2tdI
	vA5g2ZOaWAJHzgVpQAy3+CCnTaXtmF8KZ/w3nu2JXmoCXbZhuux3xaHpVkP7m370P9mY0Kz+/xJVT
	tHo2YfB3vRGku2Ngqp4vSISf9sjXCXmyTEBg1H1+Q7hdmapkX8/eSUDPL/Wle4LZT89sUgt63lg2F
	r6rJCPY/0mbDcpuXMo3jHVarUmDF57ygb4kfe0rHtBiDHjiyKosQw5CB2Q2nyGoBXRpEpmtrIjP63
	Oro/dGOq0U1/dampLxr2V4O4Xp37yis8HQQrpfHUmEXHraiPDhniqIO6zFy8pc50P8M3njKFlTbr+
	CERMdQcW0G/SuagCPMRA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goE3Y-0004UL-Om; Mon, 28 Jan 2019 21:03:00 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goE3T-0004T7-43
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 21:02:57 +0000
Received: by mail-wr1-x444.google.com with SMTP id s12so19685712wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 13:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=vZlO9co7n6/uDTvht5RilO/2CyoKXXFYrsG3E0OIe7g=;
 b=Nq5C+wnIHLTQ89b0KoW5ClGAB8qZocIeD0k+C+trrxoSRYphx3PzT1y82lv0JSAfHG
 XsavyK6Uow5TEiOS7i69PkVzsEYYEMf2ymq3Mi/cac07hM1TIWg8MorklwTZNDdAd1C/
 jOD4tXGsv1cOScXEzIqW3isSoC7VzZT3yDSrsTa4WAWRAHzGcVTsf7z+QIWAQhODXzKM
 73OAkX6IBn/ticrJZd2bdR4Q1dqXHXJ45fJcPHDfq1q3JAdj6DfJpgmOTrPgJFS1cOta
 RT1C5hIpu8CzemTSMlWI4z1lseziQy4FtOxGABn7MWTABuDbL+nZetIZuqIBzOwAtS6u
 h/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=vZlO9co7n6/uDTvht5RilO/2CyoKXXFYrsG3E0OIe7g=;
 b=cESDLXK7ogVdrlQLCj4e5TNe4xI8tzLrOc6UGLsREVNkpFPUkbHDW/38v6t8w3ZIAR
 ZdStU53R42zu8zf3lmCJplnNihEB4n0anktSe8i7CRfSq8CVdDsdjh+HMHL2mZeuU1wq
 l09smSzXWbcNJMg5uQXZXxiq36rjUJii3sj9cnyP01EAvlETxdynmrD2Z8iQyeVdstFB
 AovI8FQ4MEgdz+pgKtBXeR9iHWSi7JdJJBOFYIhgoEEwb21+oqBTsBcHOL4lCS0vN3tI
 T/DAOfg/eHsmp6fbu9McQnRqgshg56I+qz+VDHddacYDMavKLZP7KY/8zsFETmOwWHMH
 ZK5A==
X-Gm-Message-State: AJcUukf116vFhb5WT8PoCLtA6zcK9gR0v5H2U8xOli0Q+EAnF0rqEg2x
 W3+Cl1l1/VJvVaDIgul4VPbKrQ==
X-Google-Smtp-Source: ALg8bN4jnKD9KyTPFa58senj3ONnpl/HmQLtahQWLKCzYZ8E13cQ+FrGknrqArbc1oRPPxJfn1FZdA==
X-Received: by 2002:adf:e5d0:: with SMTP id a16mr23146936wrn.89.1548709372774; 
 Mon, 28 Jan 2019 13:02:52 -0800 (PST)
Received: from localhost (148.138.18.109.rev.sfr.net. [109.18.138.148])
 by smtp.googlemail.com with ESMTPSA id w10sm511877wmb.1.2019.01.28.13.02.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 13:02:52 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: arm@kernel.org
Subject: [GIT PULL] Amlogic fixes for v5.0-rc, round 2
Date: Mon, 28 Jan 2019 22:02:51 +0100
Message-ID: <7hh8dsqyv8.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_130255_156505_92D1B792 
X-CRM114-Status: GOOD (  11.59  )
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
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Olof, Arnd,

Below is round 2 of Amlogic fixes for v5.0-rc, based on top of the first
round.

Kevin


The following changes since commit 19a220dd1e8a1b1d8e5e2f8f4a25313c4b02d527:

  arm64: defconfig: enable modules for amlogic s400 sound card (2019-01-08 15:27:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes-2

for you to fetch changes up to c90c44d8aaf5895320da1621b0a502ed5528e437:

  ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning (2019-01-17 14:40:45 -0800)

----------------------------------------------------------------
Amlogic fixes for v5.0-rc, round 2
- several fixups for the GPIO cd-inverted change
- IRQ trigger fixes for MAC IRQ
- USB PHY reset/power fixes

----------------------------------------------------------------
Anand Moon (2):
      ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator power failed warning
      ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning

Carlo Caione (1):
      arm: dts: meson: Fix IRQ trigger type for macirq

Loys Ollivier (1):
      arm64: dts: meson: Fix mmc cd-gpios polarity

Martin Blumenstingl (3):
      ARM: dts: meson8b: odroidc1: mark the SD card detection GPIO active-low
      ARM: dts: meson8b: ec100: mark the SD card detection GPIO active-low
      ARM: dts: meson8m2: mxiii-plus: mark the SD card detection GPIO active-low

 arch/arm/boot/dts/meson.dtsi                                   |  2 +-
 arch/arm/boot/dts/meson8b-ec100.dts                            |  3 +--
 arch/arm/boot/dts/meson8b-odroidc1.dts                         |  4 +---
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts                      |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts           |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            | 13 +++++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi              |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts          |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            |  3 +--
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts             |  3 +--
 18 files changed, 28 insertions(+), 36 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
