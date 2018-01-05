From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 5 Jan 2018 17:56:17 +0800
Subject: [PATCH 2/6] ARM64: dts: meson-axg: uart: fix address space range
In-Reply-To: <20180105095621.196472-1-yixun.lan@amlogic.com>
References: <20180105095621.196472-1-yixun.lan@amlogic.com>
Message-ID: <20180105095621.196472-3-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The address space range is actually 0x18, fixed here.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 1c6002b3fe34..9636a7c5f6ed 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -143,14 +143,14 @@
 
 			uart_A: serial at 24000 {
 				compatible = "amlogic,meson-gx-uart";
-				reg = <0x0 0x24000 0x0 0x14>;
+				reg = <0x0 0x24000 0x0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
 
 			uart_B: serial at 23000 {
 				compatible = "amlogic,meson-gx-uart";
-				reg = <0x0 0x23000 0x0 0x14>;
+				reg = <0x0 0x23000 0x0 0x18>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
-- 
2.15.1
