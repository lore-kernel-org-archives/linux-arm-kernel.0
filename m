From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Sun, 21 Oct 2018 06:35:49 +0900
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77990: Add I2C-DVFS device node
Message-ID: <1540071349-27483-1-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds I2C-DVFS device node for the R8A77990 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the devel branch of Simon Horman's renesas tree.

 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 9df0751..5d9905f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -22,7 +22,8 @@
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
 		i2c6 = &i2c6;
-		i2c7 = &i2c7;
+		i2c7 = &i2c_dvfs;
+		i2c8 = &i2c7;
 	};
 
 	cpus {
@@ -337,6 +338,22 @@
 			reg = <0 0xe6060000 0 0x508>;
 		};
 
+		i2c_dvfs: i2c at e60b0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a77990",
+				     "renesas,rcar-gen3-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe60b0000 0 0x34>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 926>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			resets = <&cpg 926>;
+			dmas = <&dmac0 0x11>, <&dmac0 0x10>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a77990-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-- 
1.9.1
