From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 09:03:57 +0000
Subject: [PATCH 03/10] ARM: dts: atlas7: add lost gmac node
In-Reply-To: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
References: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438074244-18708-4-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ye He <Ye.He@csr.com>

this patch adds lost ethernet gmac node, and also fix the ranges of
its parent node.

Signed-off-by: Ye He <ye.he@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 3caa2cc..cc9db08 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -1236,6 +1236,7 @@
 				<0x18040000 0x18040000 0x1000>,
 				<0x18050000 0x18050000 0x1000>,
 				<0x18060000 0x18060000 0x1000>,
+				<0x180b0000 0x180b0000 0x4000>,
 				<0x18100000 0x18100000 0x3000>,
 				<0x18250000 0x18250000 0x10000>,
 				<0x18200000 0x18200000 0x1000>;
@@ -1319,6 +1320,18 @@
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
+			gmac: eth at 180b0000 {
+				compatible = "snps, dwc-eth-qos";
+				reg = <0x180b0000 0x4000>;
+				interrupts = <0 59 0>, <0 70 0>;
+				interrupt-names = "macirq", "macpmt";
+				clocks = <&car 39>, <&car 45>,
+				       <&car 86>, <&car 87>;
+				clock-names = "gnssm_rgmii", "gnssm_gmac",
+					"rgmii", "gmac";
+				local-mac-address = [00 00 00 00 00 00];
+				phy-mode = "rgmii";
+			};
 			dspub at 18250000 {
 				compatible = "dx,cc44p";
 				reg = <0x18250000 0x10000>;
-- 
1.9.1
