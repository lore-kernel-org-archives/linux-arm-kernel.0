From: stefan@agner.ch (Stefan Agner)
Date: Fri, 18 Jul 2014 19:01:39 +0200
Subject: [PATCH 3/6] ARM: dts: vf610: Add usbmisc for non-core registers
In-Reply-To: <cover.1405702442.git.stefan@agner.ch>
References: <cover.1405702442.git.stefan@agner.ch>
Message-ID: <4b3b16a8de1bd916d51c951aca286616f7ec8a9d.1405702442.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree node for usbmisc which controls the non-core USB
registers. This is required to use the property to disable the over-
current detection.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf610.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index f6c3f02..b20ce4f 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -334,11 +334,19 @@
 				interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_USBC0>;
 				fsl,usbphy = <&usbphy0>;
+				fsl,usbmisc = <&usbmisc 0>;
 				dr_mode = "peripheral";
 				status = "disabled";
 			};
 
-
+			usbmisc: usb at 40034800 {
+				#index-cells = <1>;
+				compatible = "fsl,vf610-usbmisc";
+				reg = <0x40034800 0x200>,
+					<0x400b4800 0x200>;
+				clocks = <&clks VF610_CLK_USBC0>,
+					<&clks VF610_CLK_USBC1>;
+			};
 		};
 
 		aips1: aips-bus at 40080000 {
@@ -407,6 +415,7 @@
 				interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_USBC1>;
 				fsl,usbphy = <&usbphy1>;
+				fsl,usbmisc = <&usbmisc 1>;
 				dr_mode = "host";
 				status = "disabled";
 			};
-- 
2.0.1
