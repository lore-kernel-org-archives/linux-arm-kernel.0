From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 15 Oct 2018 18:28:33 +0200
Subject: [PATCH 2/2] arm64: dts: meson-axg: drop FW reserved memory
In-Reply-To: <20181015162833.7544-1-jbrunet@baylibre.com>
References: <20181015162833.7544-1-jbrunet@baylibre.com>
Message-ID: <20181015162833.7544-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The axg does not require the FW memory region for all we know.
This seems to be something we carried for the gx family for no
reason.

Fixes: 9d59b708500f ("arm64: dts: meson-axg: add initial A113D SoC DT support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 06a06f11f114..d1beedc4fb0e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -13,9 +13,6 @@
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-axg-reset.h>
 
-/* 16 MiB reserved for Hardware ROM Firmware */
-/memreserve/ 0x0 0x1000000;
-
 /* 3 MiB reserved for ARM Trusted Firmware (BL31) */
 /memreserve/ 0x05000000 0x300000;
 
-- 
2.17.2
