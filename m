From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 21 Mar 2017 16:25:45 +0100
Subject: [PATCH v2 08/13] ARM64: dts: meson-gx: Add shared CMA dma memory pool
In-Reply-To: <1490109950-21421-1-git-send-email-narmstrong@baylibre.com>
References: <1490109950-21421-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1490109950-21421-9-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI modes needs more CMA memory to be reserved at boot-time.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 5d995f7..94c6f95 100644
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
