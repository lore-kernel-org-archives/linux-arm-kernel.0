From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu,  9 Jan 2014 13:31:47 +0100
Subject: [PATCH v2 10/12] at91: dt: sam9261: Add an entry in the DT for the
 SMC/EBI bus driver.
In-Reply-To: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
References: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1389270709-32662-11-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch creates a new entry in the device tree for the 9261 under which
should be the described the devices attached to the SMC/EBI.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 73 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 695d5d2..6c90790 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -542,6 +542,79 @@
 			status = "disabled";
 		};
 
+		smc: smc at ffffec00 {
+			#address-cells = <2>;
+			#size-cells = <1>;
+			compatible = "atmel,at91sam9261-smc";
+			reg = <0xffffec00 0x80>;
+			pinctrl-names = "default";
+			status = "disabled";
+			ranges = <0 0 0x10000000 0x10000000
+				  1 0 0x20000000 0x10000000
+				  2 0 0x30000000 0x10000000
+				  3 0 0x40000000 0x10000000
+				  4 0 0x50000000 0x10000000
+				  5 0 0x60000000 0x10000000
+				  6 0 0x70000000 0x10000000>;
+
+			ebi_cs0 at 0,0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "simple-bus";
+				ranges = <0 0 0x00000000 0x10000000>;
+				smc,cs = <0>;
+				status = "disabled";
+			};
+			ebi_cs1 at 1,0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "simple-bus";
+				ranges = <0 1 0x00000000 0x10000000>;
+				smc,cs = <1>;
+				status = "disabled";
+			};
+			ebi_cs2 at 2,0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "simple-bus";
+				ranges = <0 2 0x00000000 0x10000000>;
+				smc,cs = <2>;
+				status = "disabled";
+			};
+			ebi_cs3 at 3,0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "simple-bus";
+				ranges = <0 3 0x00000000 0x10000000>;
+				smc,cs = <3>;
+				status = "disabled";
+			};
+			ebi_cs4 at 4,0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "simple-bus";
+				ranges = <0 4 0x00000000 0x10000000>;
+				smc,cs = <4>;
+				status = "disabled";
+			};
+			ebi_cs5 at 5,0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "simple-bus";
+				ranges = <0 5 0x00000000 0x10000000>;
+				smc,cs = <5>;
+				status = "disabled";
+			};
+			ebi_cs6 at 6,0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "simple-bus";
+				ranges = <0 6 0x00000000 0x10000000>;
+				smc,cs = <6>;
+				status = "disabled";
+			};
+		};
+
 		usb0: ohci at 00500000 {
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x100000>;
-- 
1.8.5.2
