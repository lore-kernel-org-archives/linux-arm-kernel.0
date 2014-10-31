From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 21:45:30 +0100
Subject: [PATCH 1/6] ARM: nomadik: move MMC/SD card detect GPIO to board DTS
Message-ID: <1414788335-28334-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pushes the setting of the card detect GPIO pin down into
the top-level file for the board, since it is not a property of
the ASIC (which this DTSI is about) but a property of the board
design.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-s8815.dts    | 7 +++++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 1 -
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index 90d8b6c7a205..c795ee8a356a 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -65,6 +65,13 @@
 		};
 	};
 
+	/* Configure card detect for the uSD slot */
+	amba {
+		mmcsd: sdi at 101f6000 {
+			cd-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	/* Custom board node with GPIO pins to active etc */
 	usb-s8815 {
 		/* This will bias the MMC/SD card detect line */
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index dbcf521b017f..35c79eb24f93 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -844,7 +844,6 @@
 			bus-width = <4>;
 			cap-mmc-highspeed;
 			cap-sd-highspeed;
-			cd-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmcsd_default_mux>, <&mmcsd_default_mode>;
 			vmmc-supply = <&vmmc_regulator>;
-- 
1.9.3
