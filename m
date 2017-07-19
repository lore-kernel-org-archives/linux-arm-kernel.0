From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 19 Jul 2017 17:31:26 +0200
Subject: [PATCH 2/2] ARM64: dts: marvell: add NAND support on the CP110 master
In-Reply-To: <20170719153126.16905-1-gregory.clement@free-electrons.com>
References: <20170719153126.16905-1-gregory.clement@free-electrons.com>
Message-ID: <20170719153126.16905-3-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NAND controller used in A7K/A8K is present on the CP110 master
part. It is compatible with the pxa-nand driver.

Unlike most of the controller on the CP110 this one is only present on
the master for the Armada 8K SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index 726528ce54e9..9be4a442ded5 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -240,6 +240,20 @@
 				status = "disabled";
 			};
 
+			cpm_nand: nand at 720000 {
+				/*
+				 * For A7K/A8K this controller is only
+				 * present on the CPM and not on the CPS
+				 */
+				compatible = "marvell,armada370-nand";
+				reg = <0x720000 0x54>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				interrupts = <ICU_GRP_NSR 115 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cpm_clk 1 2>;
+				status = "disabled";
+			};
+
 			cpm_trng: trng at 760000 {
 				compatible = "marvell,armada-8k-rng", "inside-secure,safexcel-eip76";
 				reg = <0x760000 0x7d>;
-- 
2.13.2
