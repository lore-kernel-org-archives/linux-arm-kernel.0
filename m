From: stefan@agner.ch (Stefan Agner)
Date: Mon, 18 Aug 2014 22:07:14 +0200
Subject: [PATCH RESEND v2 4/7] ARM: dts: vf610: Add usbmisc for non-core
 registers
In-Reply-To: <cover.1408391385.git.stefan@agner.ch>
References: <cover.1408391385.git.stefan@agner.ch>
Message-ID: <53d894f3fcacd7eddd2ec11d9a67bb9ebafa201a.1408391385.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree node for usbmisc which controls the non-core USB
registers. This is required to use the property to disable the over-
current detection.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vf610.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index f36acb5..a49d739 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -334,11 +334,17 @@
 				interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_USBC0>;
 				fsl,usbphy = <&usbphy0>;
+				fsl,usbmisc = <&usbmisc0 0>;
 				dr_mode = "peripheral";
 				status = "disabled";
 			};
 
-
+			usbmisc0: usb at 40034800 {
+				#index-cells = <1>;
+				compatible = "fsl,vf610-usbmisc";
+				reg = <0x40034800 0x200>;
+				clocks = <&clks VF610_CLK_USBC0>;
+			};
 		};
 
 		aips1: aips-bus at 40080000 {
@@ -407,10 +413,18 @@
 				interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_USBC1>;
 				fsl,usbphy = <&usbphy1>;
+				fsl,usbmisc = <&usbmisc1 0>;
 				dr_mode = "host";
 				status = "disabled";
 			};
 
+			usbmisc1: usb at 400b4800 {
+				#index-cells = <1>;
+				compatible = "fsl,vf610-usbmisc";
+				reg = <0x400b4800 0x200>;
+				clocks = <&clks VF610_CLK_USBC1>;
+			};
+
 			ftm: ftm at 400b8000 {
 				compatible = "fsl,ftm-timer";
 				reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
-- 
2.0.4
