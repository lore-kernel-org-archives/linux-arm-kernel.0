Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C620C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:49:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3372133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 05:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EdOlA9HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3372133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S2jIueGDPGelKNx5tNtSoXirn4ckFDU39F4Uh7Hc0QE=; b=EdOlA9HLIvH3HG
	cbveMCDLkLT1Il0KmsRwKPZ0Tt0Vkv4LvliBdL+4uawncTfiGtAqDg2pLWilxQh62ebQaPRC8OAco
	2a6PP1r9Bv3oqe9NHrwpBKsFWzw5YW8TG2NOrzAZHdaGqGGyVHGECopFHYv8J6uC23BZ9Z6iberET
	F+Vz+D+emvH2D+PL0G32FdBo2sJA8/zQfYiHMiiSrzE/agQdePTnlqcb2VaKADw+/LgZS4oxwnW9T
	jrrQLFKdNPhbsuCTYrl3yB8vV9nVXSGfwJiiTWzBS9+z0aZeVX3Z2ZuKkRmjMtze3a8qip+189Ejm
	5sjjAc9dNelpnpA6frrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ8Fz-0003ek-57; Tue, 18 Dec 2018 05:49:27 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ8FL-00031h-2X; Tue, 18 Dec 2018 05:48:53 +0000
X-UUID: 41e27f83c0494e5e8d67dd20484d2bd3-20181218
X-UUID: 41e27f83c0494e5e8d67dd20484d2bd3-20181218
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <biao.huang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 797108285; Tue, 18 Dec 2018 13:48:28 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Dec 2018 13:48:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 13:48:26 +0800
From: Biao Huang <biao.huang@mediatek.com>
To: <davem@davemloft.net>, <robh+dt@kernel.org>
Subject: [v2, PATCH 1/2] dt-binding: mediatek-dwmac: add binding document for
 MediaTek MT2712 DWMAC
Date: Tue, 18 Dec 2018 13:48:15 +0800
Message-ID: <1545112096-22737-2-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1545112096-22737-1-git-send-email-biao.huang@mediatek.com>
References: <1545112096-22737-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 816FA2B6868C2FE092A30645F9DE58681FECB5DDC461B8300AA7297337BDCD2F2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_214847_584832_522A7325 
X-CRM114-Status: GOOD (  13.85  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, nelson.chang@mediatek.com,
 andrew@lunn.ch, biao.huang@mediatek.com, netdev@vger.kernel.org,
 liguo.zhang@mediatek.com, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
 joabreu@synopsys.com, linux-mediatek@lists.infradead.org,
 honghui.zhang@mediatek.com, yt.shen@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The commit adds the device tree binding documentation for the MediaTek DWMAC
found on MediaTek MT2712.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 .../devicetree/bindings/net/mediatek-dwmac.txt     |   78 ++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.txt b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
new file mode 100644
index 0000000..8a08621
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
@@ -0,0 +1,78 @@
+MediaTek DWMAC glue layer controller
+
+This file documents platform glue layer for stmmac.
+Please see stmmac.txt for the other unchanged properties.
+
+The device node has following properties.
+
+Required properties:
+- compatible:  Should be "mediatek,mt2712-gmac" for MT2712 SoC
+- reg:  Address and length of the register set for the device
+- interrupts:  Should contain the MAC interrupts
+- interrupt-names: Should contain a list of interrupt names corresponding to
+	the interrupts in the interrupts property, if available.
+	Should be "macirq" for the main MAC IRQ
+- clocks: Must contain a phandle for each entry in clock-names.
+- clock-names: The name of the clock listed in the clocks property. These are
+	"axi", "apb", "mac_main", "ptp_ref" for MT2712 SoC
+- mac-address: See ethernet.txt in the same directory
+- phy-mode: See ethernet.txt in the same directory
+- mediatek,pericfg: A phandle to the syscon node that control ethernet
+	interface and timing delay.
+
+Optional properties:
+- mediatek,tx-delay-ps: TX clock delay macro value. Default is 0.
+	It should be defined for RGMII/MII interface.
+- mediatek,rx-delay-ps: RX clock delay macro value. Default is 0.
+	It should be defined for RGMII/MII/RMII interface.
+Both delay properties need to be a multiple of 170 for RGMII interface,
+or will round down. Range 0~31*170.
+Both delay properties need to be a multiple of 550 for MII/RMII interface,
+or will round down. Range 0~31*550.
+
+- mediatek,rmii-rxc: boolean property, if present indicates that the RMII
+	reference clock, which is from external PHYs, is connected to RXC pin
+	on MT2712 SoC.
+	Otherwise, is connected to TXC pin.
+- mediatek,txc-inverse: boolean property, if present indicates that
+	1. tx clock will be inversed in MII/RGMII case,
+	2. tx clock inside MAC will be inversed relative to reference clock
+	   which is from external PHYs in RMII case, and it rarely happen.
+- mediatek,rxc-inverse: boolean property, if present indicates that
+	1. rx clock will be inversed in MII/RGMII case.
+	2. reference clock will be inversed when arrived at MAC in RMII case.
+- assigned-clocks: mac_main and ptp_ref clocks
+- assigned-clock-parents: parent clocks of the assigned clocks
+
+Example:
+	eth: ethernet@1101c000 {
+		compatible = "mediatek,mt2712-gmac";
+		reg = <0 0x1101c000 0 0x1300>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-names = "macirq";
+		phy-mode ="rgmii";
+		mac-address = [00 55 7b b5 7d f7];
+		clock-names = "axi",
+			      "apb",
+			      "mac_main",
+			      "ptp_ref",
+			      "ptp_top";
+		clocks = <&pericfg CLK_PERI_GMAC>,
+			 <&pericfg CLK_PERI_GMAC_PCLK>,
+			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
+			 <&topckgen CLK_TOP_ETHER_50M_SEL>;
+		assigned-clocks = <&topckgen CLK_TOP_ETHER_125M_SEL>,
+				  <&topckgen CLK_TOP_ETHER_50M_SEL>;
+		assigned-clock-parents = <&topckgen CLK_TOP_ETHERPLL_125M>,
+					 <&topckgen CLK_TOP_APLL1_D3>;
+		mediatek,pericfg = <&pericfg>;
+		mediatek,tx-delay-ps = <1530>;
+		mediatek,rx-delay-ps = <1530>;
+		mediatek,rmii-rxc;
+		mediatek,txc-inverse;
+		mediatek,rxc-inverse;
+		snps,txpbl = <32>;
+		snps,rxpbl = <32>;
+		snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
+		snps,reset-active-low;
+	};
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
