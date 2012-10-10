From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Oct 2012 16:18:54 +0100
Subject: [PATCH 5/6] ARM: ux500: Enable SDI4 port on the u9540 when booting
 with Device Tree
In-Reply-To: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
References: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1349882335-6786-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we add the device node for the SDI4 (MMC) port to the u9540
Device Tree source file. This will allow successful probing of
the internal MMC storage device when booting with DT enabled.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/u9540.dts |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/u9540.dts b/arch/arm/boot/dts/u9540.dts
index 28efe20..2dade76 100644
--- a/arch/arm/boot/dts/u9540.dts
+++ b/arch/arm/boot/dts/u9540.dts
@@ -21,7 +21,6 @@
 	};
 
 	soc-u9500 {
-
 		uart at 80120000 {
 			status = "okay";
 		};
@@ -33,5 +32,16 @@
 		uart at 80007000 {
 			status = "okay";
 		};
+
+		// On-board eMMC
+		sdi4_per2 at 80114000 {
+			arm,primecell-periphid = <0x10480180>;
+		        max-frequency = <50000000>;
+			bus-width = <8>;
+			mmc-cap-mmc-highspeed;
+			vmmc-supply = <&ab8500_ldo_aux2_reg>;
+
+			status = "okay";
+		};
 	};
 };
-- 
1.7.9.5
