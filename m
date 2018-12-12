Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3A2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:44:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3E720839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gCAS/ykk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3E720839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WYMgqbKnUcA8Kd1Y2KFLVIhdLwntf22Y9DS+ORz/UI4=; b=gCAS/ykkCEJOtU
	nUC7VCaSHSv+qSgSptm0bydWHbOLDyOCsVo+3xH0VtE/GWmtKAxWnlBw8D1sFcGYtImDzMCxoVvgZ
	ZxNI41sdAAKDl6ne/+UPYq8JJFyfz59EDim/CVAb7O6+nxuv915qcnU+HAtr515rRobSwJKBCA/pm
	uE/Ap18inY8W8PCusAvvenbgLpH2iA69oZPVaVX8w1uhFI6J4w0OaXC+TC4s3JJrrvO39IK/jTwXT
	Y6rEU5oyWcuOY9yOn/UdrSQoJH9/RfPBst8u8iYEiFYEl0snWWNSqo4qTGYVL1t8jVGzBYTLIYVaC
	5eCPU9HcscmhFRgNohmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX07T-0005XV-BI; Wed, 12 Dec 2018 08:43:51 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX07Q-0005V4-5b; Wed, 12 Dec 2018 08:43:49 +0000
Received: from p5b1274b7.dip0.t-ipconnect.de ([91.18.116.183]
 helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gX07E-0002Q9-NR; Wed, 12 Dec 2018 09:43:36 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: arm@kernel.org
Subject: [GIT PULL 1/3] Rockchip dts32 updates for 4.21 round2
Date: Wed, 12 Dec 2018 09:43:36 +0100
Message-ID: <7153021.iXIDTOc0j0@phil>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_004348_361834_B46B3724 
X-CRM114-Status: GOOD (  16.26  )
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

please find below and in the replies a second round of pull requests
for 4.21. This includes another pull for 64bit dts changes and a single
patch from Rob that should go on top of next/dt after merging the dts
changes, as it converts the board-binding txt to the newer yaml format.

This pull is also somewhat special for me, as it includes support for the
BQ Edison2 tablet (including graphics) that was the actual reason for me
to start looking into trying to get Rockchip support into mainline.

Funnily enough that was over 5 years ago - so didn't even take "long" :-D .

So please pull.
Heiko

The following changes since commit 99935bd4b5b4558beb069222e6d6143fe5830d64:

  ARM: dts: rockchip: Add all CPUs in cooling maps (2018-11-19 14:45:07 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.21-rockchip-dts32-2

for you to fetch changes up to 7841b88a8fdddc0e7f3377fc42efe4cb3be1ed8b:

  ARM: dts: rockchip: Add internal timer support for rv1108 (2018-12-11 20:38:07 +0100)

----------------------------------------------------------------
RV1108 improvements (uart-dma, clocks, interrupt numbers, gmac support
timer and emmc pins) from its first real-world user.
RK3188 improvements (OPPv2, cpu node updates) to prepare for a new
devicetree, the BQ Edison 2 Quad-Core.
VPU device node for rk3288, right now only the jpeg encoder part
will be in the kernel but hopefully other codecs will follow.

----------------------------------------------------------------
Ezequiel Garcia (1):
      ARM: dts: rockchip: add VPU device node for RK3288

Heiko Stuebner (6):
      ARM: dts: rockchip: add #sound-dai-cells to Cortex-A9 i2s
      ARM: dts: rockchip: convert rk3188 to opp-v2
      ARM: dts: rockchip: add cpu-core resets for rk3188
      ARM: dts: rockchip: add phandles to secondary cpu cores
      ARM: dts: rockchip: update cpu supplies on rk3188
      ARM: dts: rockchip: add BQ Edison 2 QC devicetree

Otavio Salvador (8):
      ARM: dts: rockchip: add rv1108 eMMC pin settings
      ARM: dts: rockchip: Add rv1108 GMAC support
      ARM: dts: rockchip: Pass the 'clock-latency' property on rv1108
      ARM: dts: rockchip: Pass the 'arm,cpu-registers-not-fw-configured' property on rv1108
      ARM: dts: rockchip: Fix the PMU interrupt number for rv1108
      ARM: dts: rockchip: Assign the proper GPIO clocks for rv1108
      ARM: dts: rockchip: Add UART DMA support for rv1108
      ARM: dts: rockchip: Add internal timer support for rv1108

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 .../bindings/timer/rockchip,rk-timer.txt           |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3066a.dtsi                     |   3 +
 arch/arm/boot/dts/rk3188-bqedison2qc.dts           | 711 +++++++++++++++++++++
 arch/arm/boot/dts/rk3188-px3-evb.dts               |  14 +-
 arch/arm/boot/dts/rk3188-radxarock.dts             |  14 +-
 arch/arm/boot/dts/rk3188.dtsi                      |  66 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  14 +-
 arch/arm/boot/dts/rv1108.dtsi                      |  84 ++-
 10 files changed, 890 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3188-bqedison2qc.dts




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
