From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 24 Feb 2014 15:53:54 -0500
Subject: [PATCH 3/4] ARM: dts: keystone: Use dma-ranges property
In-Reply-To: <1393275235-1087-1-git-send-email-santosh.shilimkar@ti.com>
References: <1393275235-1087-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1393275235-1087-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

The dma-ranges property has to be specified per bus and has format:
 < DMA addr > - Base DMA address for Bus (Bus format 32-bits)
 < CPU addr > - Corresponding base CPU address (CPU format 64-bits)
 < DMA range size > - Size of supported DMA range

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index b420290..171579d 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -96,6 +96,7 @@
 		compatible = "ti,keystone","simple-bus";
 		interrupt-parent = <&gic>;
 		ranges = <0x0 0x0 0x0 0xc0000000>;
+		dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
 
 		rstctrl: reset-controller {
 			compatible = "ti,keystone-reset";
-- 
1.7.9.5
