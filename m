From: julien.grossholtz@savoirfairelinux.com (Julien Grossholtz)
Date: Fri, 19 Feb 2016 15:59:02 -0500
Subject: [PATCH] ARM: dts: TS-4800: Add gpio driver
Message-ID: <1455915542-14467-1-git-send-email-julien.grossholtz@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dts nodes for TS-4800 FPGA gpio chips.

Signed-off-by: Julien Grossholtz <julien.grossholtz@savoirfairelinux.com>
---
 arch/arm/boot/dts/imx51-ts4800.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index 0ff76a1..c72c944 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -165,6 +165,35 @@
 			reg = <0x12000 0x1000>;
 			syscon = <&syscon 0x10 6>;
 		};
+
+		fpga_gpio0: fpga_gpio0 at b0010020 {
+			compatible = "technologic,ts4800-gpio";
+			reg = <0x10020 0x6>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		fpga_gpio1: fpga_gpio1 at b0010028 {
+			compatible = "technologic,ts4800-gpio";
+			reg = <0x10028 0x6>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		fpga_gpio2: fpga_gpio2 at b0010030 {
+			compatible = "technologic,ts4800-gpio";
+			reg = <0x10030 0x6>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		fpga_gpio3: fpga_gpio3 at b0010038 {
+			compatible = "technologic,ts4800-gpio";
+			reg = <0x10038 0x6>;
+			gpio-controller;
+			ngpios = <8>;
+			#gpio-cells = <2>;
+		};
 	};
 };
 
-- 
2.5.0
