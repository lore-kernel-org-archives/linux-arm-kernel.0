From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 13 Jan 2017 14:45:30 +0000
Subject: [PATCH RFC v2 2/4] ARM: dts: imx6*-hummingboard2: fix SD card detect
In-Reply-To: <20170113144449.GQ14217@n2100.armlinux.org.uk>
References: <20170113144449.GQ14217@n2100.armlinux.org.uk>
Message-ID: <E1cS36g-0002wI-2t@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the SD card detect signal, which was missing the polarity
specification, and the pull-up necessary for proper signalling.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 11b63f6f2b89..734487edf200 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -393,7 +393,7 @@
 
 		pinctrl_hummingboard2_usdhc2_aux: hummingboard2-usdhc2-aux {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x13071
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x1f071
 				MX6QDL_PAD_KEY_ROW1__SD2_VSELECT 0x1b071
 				MX6QDL_PAD_DISP0_DAT9__GPIO4_IO30 0x1b0b0
 			>;
@@ -520,7 +520,7 @@
 		&pinctrl_hummingboard2_usdhc2_200mhz
 	>;
 	mmc-pwrseq = <&usdhc2_pwrseq>;
-	cd-gpios = <&gpio1 4 0>;
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.7.4
