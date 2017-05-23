From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 May 2017 16:21:49 +0200
Subject: [PATCH 1/3] ARM64: dts: meson-gxl: Fix pinctrl periphs gpio-ranges
In-Reply-To: <1495549311-23660-1-git-send-email-narmstrong@baylibre.com>
References: <1495549311-23660-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495549311-23660-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio-range was badly added on the GXL dtsi, the AO pin count is 10
instead of 14.

Fixes: 84412e4e857f ("ARM64: dts: meson-gxl: Add gpio-ranges properties")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 3efad5f..4871ce5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -244,7 +244,7 @@
 			reg-names = "mux", "pull", "pull-enable", "gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl_periphs 0 14 101>;
+			gpio-ranges = <&pinctrl_periphs 0 10 101>;
 		};
 
 		emmc_pins: emmc {
-- 
1.9.1
