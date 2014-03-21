From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:07 +0100
Subject: [PATCH 10/20] ARM: u300: Convert to the common mmc DT bindings for
 highspeed mode
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-11-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmci host driver supports the common mmc DT parser, which enables
us to use the use common names instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-u300.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-u300.dts b/arch/arm/boot/dts/ste-u300.dts
index 6fe688e..82a6616 100644
--- a/arch/arm/boot/dts/ste-u300.dts
+++ b/arch/arm/boot/dts/ste-u300.dts
@@ -442,8 +442,8 @@
 			clock-names = "apb_pclk", "mclk";
 			max-frequency = <24000000>;
 			bus-width = <4>; // SD-card slot
-			mmc-cap-mmc-highspeed;
-			mmc-cap-sd-highspeed;
+			cap-mmc-highspeed;
+			cap-sd-highspeed;
 			cd-gpios = <&gpio 12 0x4>;
 			cd-inverted;
 			vmmc-supply = <&ab3100_ldo_g_reg>;
-- 
1.7.9.5
