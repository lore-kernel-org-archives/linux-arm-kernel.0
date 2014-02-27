From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 27 Feb 2014 16:17:52 -0500
Subject: [PATCH v2 7/7] ARM: dts: keystone: Udate USB node for dma properties
In-Reply-To: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1393535872-20915-8-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone supports dma-coherent on USB master and also needs
dma-ranges to specify the hardware alias memory range in which DMA
can be operational.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 171579d..de155c0 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -200,6 +200,8 @@
 			clock-names = "usb";
 			interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
 			ranges;
+			dma-coherent;
+			dma-ranges;
 			status = "disabled";
 
 			dwc3 at 2690000 {
-- 
1.7.9.5
