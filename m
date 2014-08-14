From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 14 Aug 2014 10:51:30 -0500
Subject: [PATCH 2/3] ARM: dts: socfpga: Add SD card detect
In-Reply-To: <1408031491-15609-1-git-send-email-dinguyen@opensource.altera.com>
References: <1408031491-15609-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1408031491-15609-3-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Revision D of the SOCFGPA devkit has a GPIO line used for SD/MMC card detect.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_cyclone5.dtsi      | 2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index 1ee03c4..33cad8b 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -28,7 +28,7 @@
 			};
 		};
 
-		dwmmc0 at ff704000 {
+		mmc0: dwmmc0 at ff704000 {
 			num-slots = <1>;
 			broken-cd;
 			bus-width = <4>;
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
index 45de151..d7296a5 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
@@ -68,6 +68,10 @@
 	};
 };
 
+&mmc0 {
+	cd-gpios = <&gpio1 18 0>;
+};
+
 &usb1 {
 	status = "okay";
 };
-- 
2.0.3
