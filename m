Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5BFC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:15:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44123218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IN13WINK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44123218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sfxLe0nJ7Bu6JFOftga1qRD0P09BTz1mGQjV9BFYmCE=; b=IN13WINKVDsAhO
	L3Yl3adZ6LoBMkRASYES2K3VunipBmZmpEklXxroTQaIUWsDpgtu8pTmAu3E23LMCEsSaId+9NeM6
	gDqwGCikZ+oTTiZPd+U9cOmmoddn21Z3zb/6S6LG16aVLG7GQZCJsZOEvmXX4smCrvB9voXwqsW0U
	L+oCu0Y5OsEI7iwoQoZL1HhMDW8we2F++IvLJxSswPfTJL2kGwyiSuzCaDf1SIJcxFFyHcvZkId42
	9GNh5z8G6B3kt04CwQNyspyOz5+G18SSsqrI6Eb++kpbn1X5fuMCUZg5Rz/iVpNoXzWttNE5adjQN
	IJ5AsmuX16eb8xyYmmKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmaAD-0000EK-Js; Thu, 24 Jan 2019 08:15:05 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gma9r-0008A3-V8; Thu, 24 Jan 2019 08:14:45 +0000
X-UUID: 7b495a002ffb4b9c8dcee87d8fa95426-20190124
X-UUID: 7b495a002ffb4b9c8dcee87d8fa95426-20190124
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <erin.lo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1023804720; Thu, 24 Jan 2019 00:14:19 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 00:14:17 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 16:14:09 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Thu, 24 Jan 2019 16:14:09 +0800
From: Erin Lo <erin.lo@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier
 <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v6 0/6] Add basic and clock support for Mediatek MT8183 SoC
Date: Thu, 24 Jan 2019 16:07:14 +0800
Message-ID: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_001444_003614_CF137CBE 
X-CRM114-Status: GOOD (  11.27  )
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
Cc: devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>,
 erin.lo@mediatek.com, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
 mars.cheng@mediatek.com, yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MT8183 is a SoC based on 64bit ARMv8 architecture.
It contains 4 CA53 and 4 CA73 cores.
MT8183 share many HW IP with MT65xx series.
This patchset was tested on MT8183 evaluation board and use correct clock to shell.

This series contains document bindings, device tree including interrupt, uart, clock,
pinctrl, spi, and pwrap.

Based on v5.0-rc1 and
http://lists.infradead.org/pipermail/linux-mediatek/2018-December/016243.html

Change in v6:
1. Remove power and iommu nodes
2. Fix dtb build warning
3. Fix pinctrl binding doc
4. Fix '_' in node names

Change in v5:
1. Collect all device tree nodes to the last patch
2. Add PMU
3. Add Signed-off-by
4. Remove clock driver code and binding doc
5. Add pinctrl, iommu, spi, and pwrap nodes

Change in v4:
1. Correct syntax error in dtsi
2. Add MT8183 clock support

Change in v3:
1. Fill out GICC, GICH, GICV regions
2. Update Copyright to 2018

Change in v2:
1. Split dt-bindings into different patches 2. Correct bindings for supported SoCs (mtk-uart.txt)

Ben Ho (1):
  arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
    Makefile

Erin Lo (3):
  dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
  dt-bindings: mtk-sysirq: Add compatible for Mediatek MT8183
  dt-bindings: serial: Add compatible for Mediatek MT8183

Seiya Wang (1):
  irqchip/mtk-sysirq: support 4 interrupt parameters for sysirq

Zhiyong Tao (1):
  dt-bindings: pinctrl: mt8183: add binding document

 Documentation/devicetree/bindings/arm/mediatek.txt |    4 +
 .../interrupt-controller/mediatek,sysirq.txt       |    1 +
 .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt |  115 ++
 .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
 arch/arm64/boot/dts/mediatek/Makefile              |    1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |  136 +++
 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h      | 1120 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  408 +++++++
 drivers/irqchip/irq-mtk-sysirq.c                   |    4 +-
 9 files changed, 1788 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi

--
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
