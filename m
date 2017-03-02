From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  2 Mar 2017 16:40:04 +0100
Subject: [PATCH 08/11] ARM64: dts: meson-gx: Add shared CMA dma memory pool
In-Reply-To: <1488469207-523-1-git-send-email-narmstrong@baylibre.com>
References: <1488469207-523-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1488469207-523-9-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI modes needs more CMA memory to be reserved at boot-time.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 0cbe24b..fc03f0e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -71,6 +71,14 @@
 			reg = <0x0 0x10000000 0x0 0x200000>;
 			no-map;
 		};
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0xbc00000>;
+			alignment = <0x0 0x400000>;
+			linux,cma-default;
+		};
 	};
 
 	cpus {
-- 
1.9.1
