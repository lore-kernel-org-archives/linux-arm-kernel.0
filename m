From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 27 Feb 2014 16:17:51 -0500
Subject: [PATCH v2 6/7] ARM: dts: keystone: Use dma-ranges property
In-Reply-To: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1393535872-20915-7-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

The dma-ranges property has to be specified per bus and has format:
 < DMA addr > - Base DMA address for Bus (Bus format 32-bits)
 < CPU addr > - Corresponding base CPU address (CPU format 64-bits)
 < DMA range size > - Size of supported DMA range

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
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
