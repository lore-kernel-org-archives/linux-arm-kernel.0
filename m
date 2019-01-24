Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B6AC282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:13:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 633342184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iqzT5el5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="cl2neZV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633342184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=yYY/82rKZcJ5NrpJo2yHJz9m2WkxJ7Oq7je9ZIp4T1M=; b=iqz
	T5el5X24St8EBJSc7w7nQ2hCv6M35iHqTRP9p43+MnVwpt0nk/6enlOZ9sX27EbcTHRMVFHqfKu0V
	sZovX8fVmdWY4wozTq5mMx9d42FrinER+UF3UMq68bNeAEp+f5svSjc6tmwC0k32+5DC9dc3GW9xM
	vROOouRjd+TtvHM3NlqaiOk+E1H65GMlmeCf6gA0zUIqAj4oUYvMFUci++rUg750GRY+Ixnr9M6Ui
	y221CusthIRS6PenYrePTZsqD0Uxv7b/jPkgC+YZeTpauRosU4H+2Ss58nxONenAtolnw6aGO85EE
	E9bOD2SVvwn9Re8aibQydJLeCi6baJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmggz-0001K7-FC; Thu, 24 Jan 2019 15:13:21 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmggK-0000rX-MH
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:13:05 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 8583C25B769;
 Fri, 25 Jan 2019 02:12:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342759; bh=issk7FBYbyy/2PSPtlN0wumYv5+re1LfxIW0OtXDvr8=;
 h=From:To:Cc:Subject:Date:From;
 b=cl2neZV6Bmm44KQvxpWyw7b9myX8vJK/iHI1OqMjlyTb1IsTfSzE5J3k2DIfrw/EK
 MdNn/tmi/CAfcCW7Y4b6nVCumC9dcLaQR1Ge8i4qIGLsI/aoZUIsrR4t0ra8EVd1j8
 QdTsKLraoLIvBlPi93ePXp4DNPBdlCkar74Ystr4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 8B287940471; Thu, 24 Jan 2019 16:12:37 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v5.1
Date: Thu, 24 Jan 2019 16:12:32 +0100
Message-Id: <cover.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_071241_471326_4A597BD3 
X-CRM114-Status: GOOD (  14.15  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Simon Horman <horms+renesas@verge.net.au>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC DT updates for v5.1.

I am sending this pull-request now as a number of patches
have accumulated in this branch. I expect to send a follow-up
pull-request closer to the usual rc6 timing.


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v5.1

for you to fetch changes up to 3e279a1d44d73aea9ce428ae68e76bf85117031a:

  arm64: dts: renesas: r8a77990: ebisu: Enable HS400 of SDHI3 (2019-01-23 09:45:41 +0100)

----------------------------------------------------------------
Renesas ARM64 Based SoC DT Updates for v5.1

R-Car H3 (r8a7795) SoC
- Sort i2c and pciec0 nodes within soc node
R-Car H3 (r8a7795) and M3-W (r8a7796) SoCs
- Remove BUSIF0 settings from rcar_sound,ssi

R-Car M3-W (r8a7796) based Salvator-XS board
- Convert to new LVDS DT bindings

R-Car H3 (r8a7795), M3-W (r8a7796) and M3-N (r8a77965) based ULCB boards
- Use audio-graph-card to allow secondary sound device on kingfisher
  daugher board
- Add HDMI sound support

Kingfisher daughterboard for R-Car H3 (r8a7795), M3-W (r8a7796) and M3-N
(r8a77965) based ULCB boards
- Add pcm3168 sound codec

R-Car E3 (r8a77990) SoC
- Enable DMA for SCIF2

R-Car E3 (r8a77990) based Ebisu board
- HS400 for onboard eMMC
- Use simple-audio-card rather than simple-scu-audio-card
- Correct EthernetAVB phy mode as rgmii
- Add backlight and follow-up to correct duplicate regulator number

R-Car V3M (r8a77970) based v3msk starter kit
- Specify EtherAVB PHY IRQ now that GPIO support is present

R-Car D3 (r8a77995) based draak board
- Set better backlight levels

RZ/G2M (r8a774a1) SoC
- Correct hsusb reg size

RZ/G2E (r8a774c0) SoC
- Intial SoC DT
- Add: and SYS-DMAC controller, SCIF, HSCIF, INTC-EX
  PFC, GPIO, Ethernet AVB, watchdog, secondary CA3 core, SDHI,
  I2C, IIC-DVFS, IPMU, CAN, thermal, MSIOF, audio, PWM, display output,
  USB2.0, USB-DMAC, HSUSB, USB3.0, IPMMU, PCIe, VIN and CSI-2 support
- A follow-up patch included in this pull-request enables DMA for SCIF2
  so that DMA is enabled for all SCIF nodes

----------------------------------------------------------------
Fabrizio Castro (27):
      arm64: dts: renesas: Initial device tree for r8a774c0
      arm64: dts: renesas: r8a774c0: Add SYS-DMAC controller nodes
      arm64: dts: renesas: r8a774c0: Add SCIF and HSCIF nodes
      arm64: dts: renesas: r8a774c0: Add INTC-EX device node
      arm64: dts: renesas: r8a774c0: Add PFC support
      arm64: dts: renesas: r8a774c0: Add GPIO device nodes
      arm64: dts: renesas: r8a774c0: Add Ethernet AVB node
      arm64: dts: renesas: r8a774c0: Add watchdog support
      arm64: dts: renesas: r8a774c0: Add secondary CA53 CPU core
      arm64: dts: renesas: r8a774c0: Add SDHI nodes
      arm64: dts: renesas: r8a774c0: Add I2C and IIC-DVFS support
      arm64: dts: renesas: r8a774c0: Add IPMMU device nodes
      arm64: dts: renesas: r8a774c0: Add CAN nodes
      arm64: dts: renesas: r8a774c0: Add thermal support
      arm64: dts: renesas: r8a774c0: Add MSIOF nodes
      arm64: dts: renesas: r8a774c0: Add audio support
      arm64: dts: renesas: r8a774c0: Add PWM support
      arm64: dts: renesas: r8a774c0: Add display output support
      arm64: dts: renesas: r8a774c0: Add USB2.0 phy and host device nodes
      arm64: dts: renesas: r8a774c0: Add USB-DMAC and HSUSB device nodes
      arm64: dts: renesas: r8a774c0: Add USB3.0 device nodes
      arm64: dts: renesas: r8a774c0: Connect RZ/G2E SYS-DMAC to IPMMU
      arm64: dts: renesas: r8a774c0: Connect RZ/G2E AVB to IPMMU
      arm64: dts: renesas: r8a774c0: Connect RZ/G2E Audio-DMAC to IPMMU
      arm64: dts: renesas: r8a774c0: Add PCIe device node
      arm64: dts: renesas: r8a774c0: Add VIN and CSI-2 device nodes
      arm64: dts: renesas: r8a774a1: Fix hsusb reg size

Geert Uytterhoeven (4):
      arm64: dts: renesas: r8a77990: Sort i2c nodes within soc node
      arm64: dts: renesas: r8a7796: salvator-xs: Convert to new LVDS DT bindings
      arm64: dts: renesas: r8a774c0: Enable DMA for SCIF2
      arm64: dts: renesas: r8a77990: Enable DMA for SCIF2

Kazuya Mizuguchi (1):
      arm64: dts: renesas: r8a77990: ebisu: Fix EthernetAVB phy mode to rgmii

Kuninori Morimoto (6):
      arm64: dts: renesas: ulcb: use audio-graph-card
      arm64: dts: renesas: ulcb: add HDMI sound support
      arm64: dts: renesas: ulcb-kf: add pcm3168 sound codec
      arm64: dts: renesas: r8a7795: remove BUSIF0 settings from rcar_sound,ssi
      arm64: dts: renesas: r8a7796: remove BUSIF0 settings from rcar_sound,ssi
      arm64: dts: renesas: r8a77990-ebisu: use simple-audio-card

Laurent Pinchart (2):
      arm64: dts: renesas: r8a77990: ebisu: Add backlight
      arm64: dts: renesas: r8a77995: draak: Set better backlight levels

Marek Vasut (1):
      arm64: dts: renesas: r8a77990: ebisu: Fix backlight regulator numbering

Sergei Shtylyov (1):
      arm64: dts: renesas: v3msk: specify EtherAVB PHY IRQ

Simon Horman (2):
      arm64: dts: renesas: r8a77990: sort pciec0 node within soc node
      arm64: dts: renesas: r8a77990: ebisu: Enable HS400 of SDHI3

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          | 1751 ++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   40 +-
 .../arm64/boot/dts/renesas/r8a7796-salvator-xs.dts |    3 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |   40 +-
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |    2 +
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts     |   26 +-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |  194 +--
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     |    4 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |  138 ++
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |   70 +-
 11 files changed, 2107 insertions(+), 163 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0.dtsi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
