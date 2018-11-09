From: yangxuan8282@gmail.com (He Yangxuan)
Date: Fri, 9 Nov 2018 20:59:36 +0800
Subject: [PATCH] ARM64: dts: meson: p230: disable advertisement EEE for GbE.
Message-ID: <20181109125936.3siduqtjmj6vv5ur@raspberrypi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch disable EEE advertisement for P230 board (DWMAC + RTL8211F).
If not disable it, the network connection is not stable, will got issues
like throughput drop or broken link.

Signed-off-by: He Yangxuan <yangxuan8282@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
index 15014faa2..0c8e8305b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
@@ -86,6 +86,7 @@
 		max-speed = <1000>;
 		interrupt-parent = <&gpio_intc>;
 		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+		eee-broken-1000t;
 	};
 };
 
-- 
2.11.0
