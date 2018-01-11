From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 11 Jan 2018 10:33:57 +0800
Subject: [PATCH v3 1/5] ARM64: dts: meson: uart: fix address space range
In-Reply-To: <20180111023401.125658-1-yixun.lan@amlogic.com>
References: <20180111023401.125658-1-yixun.lan@amlogic.com>
Message-ID: <20180111023401.125658-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address space range is actually 0x18, fixed here.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index a80632641b39..70c776ef7aa7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -165,14 +165,14 @@
 
 			uart_A: serial at 24000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
-				reg = <0x0 0x24000 0x0 0x14>;
+				reg = <0x0 0x24000 0x0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
 
 			uart_B: serial at 23000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
-				reg = <0x0 0x23000 0x0 0x14>;
+				reg = <0x0 0x23000 0x0 0x18>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 6cb3c2a52baf..4ee2e7951482 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -235,14 +235,14 @@
 
 			uart_A: serial at 84c0 {
 				compatible = "amlogic,meson-gx-uart";
-				reg = <0x0 0x84c0 0x0 0x14>;
+				reg = <0x0 0x84c0 0x0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
 
 			uart_B: serial at 84dc {
 				compatible = "amlogic,meson-gx-uart";
-				reg = <0x0 0x84dc 0x0 0x14>;
+				reg = <0x0 0x84dc 0x0 0x18>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
@@ -287,7 +287,7 @@
 
 			uart_C: serial at 8700 {
 				compatible = "amlogic,meson-gx-uart";
-				reg = <0x0 0x8700 0x0 0x14>;
+				reg = <0x0 0x8700 0x0 0x18>;
 				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
@@ -404,14 +404,14 @@
 
 			uart_AO: serial at 4c0 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
-				reg = <0x0 0x004c0 0x0 0x14>;
+				reg = <0x0 0x004c0 0x0 0x18>;
 				interrupts = <GIC_SPI 193 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
 
 			uart_AO_B: serial at 4e0 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
-				reg = <0x0 0x004e0 0x0 0x14>;
+				reg = <0x0 0x004e0 0x0 0x18>;
 				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
-- 
2.15.1
