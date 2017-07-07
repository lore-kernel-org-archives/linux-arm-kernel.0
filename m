From: joseph.kogut@gmail.com (Joseph Kogut)
Date: Thu,  6 Jul 2017 18:32:57 -0700
Subject: [PATCH] ARM64: meson-gxl: disable broken eee
Message-ID: <20170707013257.18250-1-joseph.kogut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Meson GXL appears to suffer from the same broken eee issue as GXB,
originally fixed by feb3cbea0946.

This patch disables the broken energy-efficient ethernet for GXL,
avoiding the tx link breakage.

Signed-off-by: Joseph Kogut <joseph.kogut@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 8d4f3160a0ee..620e8a4f9bb3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -570,6 +570,7 @@
 				compatible = "ethernet-phy-id0181.4400", "ethernet-phy-ieee802.3-c22";
 				reg = <8>;
 				max-speed = <100>;
+				eee-broken-100tx;
 			};
 		};
 
-- 
2.13.2
