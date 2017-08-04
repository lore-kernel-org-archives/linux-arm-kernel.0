From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  4 Aug 2017 20:08:12 +0200
Subject: [PATCH 2/6] ARM64: dts: meson-gxl: libretech-cc: add card regulator
 settle times
In-Reply-To: <20170804180816.18737-1-jbrunet@baylibre.com>
References: <20170804180816.18737-1-jbrunet@baylibre.com>
Message-ID: <20170804180816.18737-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changing the card voltage on the cc is not instantaneous, especially
when switching from 3.3v to 1.8v.

It take at least 30ms for the regulator to go from 3.3v to 1.8v. Add
margin to that to make sure we don't upset the sdcard during the voltage
switch

Fixes: 61ff2af9b278 ("ARM64: dts: fixup libretech cc definition")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 51c4ecc3b31e..185d737f1549 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -92,6 +92,9 @@
 
 		states = <3300000 0>,
 		         <1800000 1>;
+
+		regulator-settling-time-up-us = <200>;
+		regulator-settling-time-down-us = <50000>;
 	};
 
 	vddio_boot: regulator-vddio_boot {
-- 
2.9.4
