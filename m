From: abhishek.shah@broadcom.com (Abhishek Shah)
Date: Sat, 29 Jul 2017 10:12:24 +0530
Subject: [PATCH 2/7] arm64: dts: Add MDIO multiplexer DT node for Stingray
In-Reply-To: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
References: <1501303349-30007-1-git-send-email-abhishek.shah@broadcom.com>
Message-ID: <1501303349-30007-3-git-send-email-abhishek.shah@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinath Mannam <srinath.mannam@broadcom.com>

Added MDIO multiplexer iproc DT node for Stingray, which contains
the child nodes of PCIe serdes, RGMII, SATA and USB phy MDIO slaves.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index a63c465..697401d 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -275,6 +275,37 @@
 
 		#include "stingray-pinctrl.dtsi"
 
+		mdio_mux_iproc: mdio-mux at 0002023c {
+			compatible = "brcm,mdio-mux-iproc";
+			reg = <0x0002023c 0x14>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mdio at 0 { /* PCIe serdes */
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			mdio at 2 { /* SATA */
+				reg = <0x2>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			mdio at 3 { /* USB */
+				reg = <0x3>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			mdio at 10 { /* RGMII */
+				reg = <0x10>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		pwm: pwm at 00010000 {
 			compatible = "brcm,iproc-pwm";
 			reg = <0x00010000 0x1000>;
-- 
2.7.4
