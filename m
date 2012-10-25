From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2012 10:57:04 +0100
Subject: [PATCH 1/8] ARM: ux500: Enable all MMC devices on the u9540 when
 booting with DT
In-Reply-To: <1351159031-25391-1-git-send-email-lee.jones@linaro.org>
References: <1351159031-25391-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1351159031-25391-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The u9540 supports 3 MMC devices. This patch enables two of them
and updates the configuration of the already enabled SDI4 port.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/u9540.dts |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/u9540.dts b/arch/arm/boot/dts/u9540.dts
index 2dade76..95892ec 100644
--- a/arch/arm/boot/dts/u9540.dts
+++ b/arch/arm/boot/dts/u9540.dts
@@ -33,10 +33,35 @@
 			status = "okay";
 		};
 
+		// External Micro SD slot
+		sdi0_per1 at 80126000 {
+			arm,primecell-periphid = <0x10480180>;
+			max-frequency = <100000000>;
+			bus-width = <4>;
+			mmc-cap-sd-highspeed;
+			mmc-cap-mmc-highspeed;
+			vmmc-supply = <&ab8500_ldo_aux3_reg>;
+
+			cd-gpios  = <&gpio7 6 0x4>; // 230
+			cd-inverted;
+
+			status = "okay";
+		};
+
+
+		// WLAN SDIO channel
+		sdi1_per2 at 80118000 {
+			arm,primecell-periphid = <0x10480180>;
+			max-frequency = <50000000>;
+			bus-width = <4>;
+
+			status = "okay";
+		};
+
 		// On-board eMMC
 		sdi4_per2 at 80114000 {
 			arm,primecell-periphid = <0x10480180>;
-		        max-frequency = <50000000>;
+		        max-frequency = <100000000>;
 			bus-width = <8>;
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux2_reg>;
-- 
1.7.9.5
