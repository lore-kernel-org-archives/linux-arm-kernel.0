From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Tue, 10 Jul 2012 10:08:07 +0300
Subject: [PATCH 1/6] ARM: apx4devkit: add NAND support
In-Reply-To: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
References: <1341904092-13777-1-git-send-email-lauri.hintsala@bluegiga.com>
Message-ID: <1341904092-13777-2-git-send-email-lauri.hintsala@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
---
 arch/arm/boot/dts/apx4devkit.dts |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/apx4devkit.dts b/arch/arm/boot/dts/apx4devkit.dts
index a670a90..ecad288 100644
--- a/arch/arm/boot/dts/apx4devkit.dts
+++ b/arch/arm/boot/dts/apx4devkit.dts
@@ -11,6 +11,12 @@
 
 	apb at 80000000 {
 		apbh at 80000000 {
+			gpmi-nand at 8000c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
+				status = "okay";
+			};
+
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx28-mmc";
 				pinctrl-names = "default";
-- 
1.7.9.5
