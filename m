From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 19 Oct 2017 14:01:43 +0200
Subject: [PATCH 5/5] ARM64: dts: meson-gx: add external PHY interrupt on some
 platforms
In-Reply-To: <20171019120143.20581-1-jbrunet@baylibre.com>
References: <20171019120143.20581-1-jbrunet@baylibre.com>
Message-ID: <20171019120143.20581-6-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the external PHY interrupt on the nanopi-k2, odroid-c2, p200, p230
and q200

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts      | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts       | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 2e853c082a65..4a4251001bfd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -168,6 +168,8 @@
 		eth_phy0: ethernet-phy at 0 {
 			/* Realtek RTL8211F (0x001cc916) */
 			reg = <0>;
+			interrupt-parent = <&gpio_intc>;
+			interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 1deaa53c9fb5..fac5c3eeb07d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -157,6 +157,8 @@
 
 		eth_phy0: ethernet-phy at 0 {
 			reg = <0>;
+			interrupt-parent = <&gpio_intc>;
+			interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
 			eee-broken-1000t;
 		};
 	};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index 2054a474e0a9..9bf16bb7c491 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -117,6 +117,8 @@
 		eth_phy0: ethernet-phy at 3 {
 			/* Micrel KSZ9031 (0x00221620) */
 			reg = <3>;
+			interrupt-parent = <&gpio_intc>;
+			interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
index 6827f235d7cf..4f3f03fc31b0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
@@ -128,6 +128,8 @@
 		compatible = "ethernet-phy-id001c.c916", "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
 		max-speed = <1000>;
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
index b65776b01911..66c6da7e112c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
@@ -110,6 +110,8 @@
 		compatible = "ethernet-phy-id001c.c916", "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
 		max-speed = <1000>;
+		interrupt-parent = <&gpio_intc>;
+		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-- 
2.13.6
