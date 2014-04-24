From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 24 Apr 2014 11:42:22 -0400
Subject: [PATCH 4/4] ARM: dts: keystone: Update USB node for dma properties
In-Reply-To: <1398354142-2767-1-git-send-email-santosh.shilimkar@ti.com>
References: <1398354142-2767-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1398354142-2767-5-git-send-email-santosh.shilimkar@ti.com>
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
index 404ff1f..5d16e4d 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -170,6 +170,8 @@
 			clock-names = "usb";
 			interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
 			ranges;
+			dma-coherent;
+			dma-ranges;
 			status = "disabled";
 
 			dwc3 at 2690000 {
-- 
1.7.9.5
