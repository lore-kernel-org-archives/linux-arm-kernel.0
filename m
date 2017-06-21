From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 21 Jun 2017 15:49:52 +0800
Subject: [PATCH 2/2] arm: dts: mt7623: fixup binding violation missing reset
 in ethernet node
In-Reply-To: <cover.1498030300.git.sean.wang@mediatek.com>
References: <cover.1498030300.git.sean.wang@mediatek.com>
Message-ID: <815802f1dfce820b435ab67ecfc944fc169c4299.1498030300.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

fix up binding violation where the reset property is required
additionally.

Cc: John Crispin <john@phrozen.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index 2202c40..2eca877 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -782,6 +782,10 @@
 			 <&ethsys CLK_ETHSYS_GP2>,
 			 <&apmixedsys CLK_APMIXED_TRGPLL>;
 		clock-names = "ethif", "esw", "gp1", "gp2", "trgpll";
+		resets = <&ethsys MT2701_ETHSYS_FE_RST>,
+			 <&ethsys MT2701_ETHSYS_GMAC_RST>,
+			 <&ethsys MT2701_ETHSYS_PPE_RST>;
+		reset-names = "fe", "gmac", "ppe";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
 		mediatek,ethsys = <&ethsys>;
 		mediatek,pctl = <&syscfg_pctl_a>;
-- 
2.7.4
