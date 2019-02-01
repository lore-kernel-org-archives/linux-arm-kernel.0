Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8632C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:24:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BB021907
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bzzeSgZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BB021907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qM16lwzq03AJnS04UAeFAXCT/KZu3bCWz3fs57OD624=; b=bzzeSgZNVDTWiK
	6Mx3irydi6b/IZSUUjemTYz/F5NxDh0Mo4+6tmjxU5m1z84aKwNPOIwEXmX9QVTgociAct4m9XHxM
	PwqW5Bdllc0Wa9ioYK0JY+RwnWHXsXCvJR727mDdiG9PwcXtRfA2cxWwExE8vrFrappyg+g9abH7h
	m3VYC96zHmjBK9zkGIedYEN2vQ1C5k5DHndi5kzPO+2/uK45GfGAx0EhqqnnbnR8RlvZeJZvYAmtA
	Xh7KsS5XHiEj/4bc/aFfsHvGlGbL0QHney/jhC+P2eCd3gSQ4UfqgqdbFUh9W2oXJ8kEfZiOcR3aO
	yfp993kZf7QdZbg4/KZg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpWvu-00072t-8P; Fri, 01 Feb 2019 11:24:30 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpWvK-0006Qs-Ht; Fri, 01 Feb 2019 11:24:26 +0000
Received: from [88.128.81.210] (helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gpWvJ-00018j-3C; Fri, 01 Feb 2019 12:23:53 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: arm@kernel.org
Subject: [GIT PULL 1/2] Rockchip dts32 updates for 5.1
Date: Fri, 01 Feb 2019 12:23:57 +0100
Message-ID: <2570520.8EeqtpO5V7@phil>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_032355_730075_986F6B98 
X-CRM114-Status: GOOD (  15.33  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Kevin Olof,

please find below and in the reply a round of Rockchip devicetree updates
targetted at 5.1. Nothing major, some new boards including the first
actual product based on the rv1108 single-core soc and a number of
general updates - Please pull

Thanks
Heiko


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v5.1-rockchip-dts32-1

for you to fetch changes up to e6b97a47b5b9512828859778acafd3fe107b395e:

  ARM: dts: rockchip: clean up the abuse of disable-wp (2019-01-28 10:51:55 +0100)

----------------------------------------------------------------
New board the Elgin-R1 based on the rv1108 soc and a number of small
improvements for rv1108 as well. RK3066 got support for the core
display components and the Edison tablet got its touchscreen added.
Apart from that a wider fix to drop display-wp usage from places where
it shouldn't be used, a pin fix for Edison and a cleanup to prevent
rk3036 board from defining sound-dai-cells for core components in
each board separately.

----------------------------------------------------------------
Heiko Stuebner (3):
      ARM: dts: rockchip: move rk3036 i2s sound-dail-cells into soc dtsi
      ARM: dts: rockchip: fix cif1_pdn pin on rk3188-bqedison2qc
      ARM: dts: rockchip: add focaltech touchscreen to rk3188-bqedison2qc

Johan Jonker (1):
      ARM: dts: rockchip: add HCLK_HDMI to rk3066 vio power-domain

Mark Yao (1):
      ARM: dts: rockchip: add rk3066 vop display nodes

Otavio Salvador (4):
      ARM: dts: rockchip: Add missing dma-names SPI support for rv1108
      ARM: dts: rockchip: rv1108: Add spim0 and spim1 pinctrl groups
      dt-bindings: Add vendor prefix for elgin
      ARM: dts: rv1108: Add support for rv1108-elgin-r1 board

Shawn Lin (1):
      ARM: dts: rockchip: clean up the abuse of disable-wp

 .../devicetree/bindings/arm/rockchip.yaml          |   5 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3036-kylin.dts                 |   1 -
 arch/arm/boot/dts/rk3036.dtsi                      |   1 +
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   1 -
 arch/arm/boot/dts/rk3066a-mk808.dts                |   1 -
 arch/arm/boot/dts/rk3066a-rayeager.dts             |   2 -
 arch/arm/boot/dts/rk3066a.dtsi                     |  48 +++++
 arch/arm/boot/dts/rk3188-bqedison2qc.dts           |  18 +-
 arch/arm/boot/dts/rk3188-px3-evb.dts               |   1 -
 arch/arm/boot/dts/rk3229-evb.dts                   |   1 -
 arch/arm/boot/dts/rk3288-fennec.dts                |   1 -
 arch/arm/boot/dts/rk3288-firefly-reload.dts        |   1 -
 arch/arm/boot/dts/rk3288-miqi.dts                  |   1 -
 arch/arm/boot/dts/rk3288-popmetal.dts              |   1 -
 arch/arm/boot/dts/rk3288-rock2-square.dts          |   1 -
 arch/arm/boot/dts/rk3288-tinker-s.dts              |   1 -
 arch/arm/boot/dts/rk3288-vyasa.dts                 |   1 -
 arch/arm/boot/dts/rv1108-elgin-r1.dts              | 206 +++++++++++++++++++++
 arch/arm/boot/dts/rv1108.dtsi                      |  37 ++++
 21 files changed, 315 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/boot/dts/rv1108-elgin-r1.dts




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
