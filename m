From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 20 Apr 2015 13:50:24 -0500
Subject: [PATCHv2 3/4] ARM: socfpga: dts: enable UART1 for the debug uart
In-Reply-To: <1429555825-23560-1-git-send-email-dinguyen@opensource.altera.com>
References: <1429555825-23560-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1429555825-23560-4-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Arria10 devkit is using UART1 for the debug uart port. Remove
unused aliases.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v2: Add removal of unused aliases
---
 arch/arm/boot/dts/socfpga_arria10.dtsi      | 12 ------------
 arch/arm/boot/dts/socfpga_arria10_socdk.dts |  8 ++++----
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index d843609..6c3ad92 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -21,18 +21,6 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-	aliases {
-		ethernet0 = &gmac0;
-		ethernet1 = &gmac1;
-		ethernet2 = &gmac2;
-		serial0 = &uart0;
-		serial1 = &uart1;
-		timer0 = &timer0;
-		timer1 = &timer1;
-		timer2 = &timer2;
-		timer3 = &timer3;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dts b/arch/arm/boot/dts/socfpga_arria10_socdk.dts
index 3015ce8..811a61c 100755
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dts
@@ -40,9 +40,9 @@
 				};
 			};
 		};
-
-		serial0 at ffc02000 {
-			status = "okay";
-		};
 	};
 };
+
+&uart1 {
+	status = "okay";
+};
-- 
2.2.1
