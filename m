Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7DFC6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:57:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EBD20873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jRkKekRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EBD20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EC862DEA+uOwqRXnGLxq4jbwTWR6a7yEO4vkWWWU3Rg=; b=jRkKekRovpnJkT
	7tX7+CgmaHr/dhBnviRJZ3t25RUUHyLG5GPdnrtKM6howTQBGoE/Bf2RZfqCvF2PEiXlVrHDfC0Vl
	vDv8oX2JJ+vVRHCh5sRQlySXU75hKS1d+xd6PbvTqb7Lc/kVVtTzYuvGA8e1CXYoTLnLbmg0gul2j
	Nfbdsj/nx34C2VNkQRtsRdePF+jFobvjlsmkisKbLaiLbMfV/89zxMgzSFlviPejhSBNNyM/LWkvf
	4sasQ/ZedZMlrewqqZWveqrSVx5/tAo3506l2tNI82oR5rC47TdfZscKX7jgkoFDldlLtBRTUXKll
	LDn/AGCyXWPPpWvDaTZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXGFU-0007Sf-NS; Thu, 13 Dec 2018 01:57:12 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXGF8-00074D-E1; Thu, 13 Dec 2018 01:56:53 +0000
X-UUID: 503c09e2c30c4f56912b463af71065de-20181213
X-UUID: 503c09e2c30c4f56912b463af71065de-20181213
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <biao.huang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 856517064; Thu, 13 Dec 2018 09:56:22 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Dec 2018 09:56:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Dec 2018 09:56:20 +0800
From: Biao Huang <biao.huang@mediatek.com>
To: <davem@davemloft.net>, <robh+dt@kernel.org>
Subject: [v7, PATCH 2/2] dt-binding: mediatek-dwmac: add binding document for
 MediaTek MT2712 DWMAC
Date: Thu, 13 Dec 2018 09:56:13 +0800
Message-ID: <1544666173-5121-3-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
References: <1544666173-5121-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_175650_726299_16A67164 
X-CRM114-Status: GOOD (  12.60  )
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
 .../devicetree/bindings/net/mediatek-dwmac.txt     |   87 ++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt

diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.txt b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
new file mode 100644
index 0000000..4de479b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
@@ -0,0 +1,87 @@
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
+	It should be defined for rgmii/rgmii-rxid/mii interface.
+- mediatek,rx-delay-ps: RX clock delay macro value. Default is 0.
+	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
+Both delay properties need to be a multiple of 170 for fine-tune rgmii,
+range 0~31*170.
+Both delay properties need to be a multiple of 550 for coarse-tune rgmii,
+range 0~31*550.
+Both delay properties need to be a multiple of 550 for mii/rmii,
+range 0~31*550.
+
+- mediatek,fine-tune: boolean property, if present indicates that fine delay
+	is selected for rgmii interface.
+	If present, tx-delay-ps/rx-delay-ps is 170+/-50ps per stage.
+	Else tx-delay-ps/rx-delay-ps of coarse delay macro is 0.55+/-0.2ns per stage.
+	This property do not apply to non-rgmii PHYs.
+	Only coarse-tune delay is supported for mii/rmii PHYs.
+- mediatek,rmii-rxc: boolean property, if present indicates that the rmii
+	reference clock, which is from external PHYs, is connected to RXC pin
+	on MT2712 SoC.
+	Otherwise, is connected to TXC pin.
+- mediatek,txc-inverse: boolean property, if present indicates that
+	1. tx clock will be inversed in mii/rgmii case,
+	2. tx clock inside MAC will be inversed relative to reference clock
+	   which is from external PHYs in rmii case, and it rarely happen.
+- mediatek,rxc-inverse: boolean property, if present indicates that
+	1. rx clock will be inversed in mii/rgmii case.
+	2. reference clock will be inversed when arrived at MAC in rmii case.
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
+		mediatek,fine-tune;
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
