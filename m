From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 1 Oct 2014 13:37:32 +0300
Subject: [PATCH 2/4] ARM: dts: keystone-k2e: update usb1 node for dma
 properties
In-Reply-To: <1412159854-21143-1-git-send-email-grygorii.strashko@ti.com>
References: <1412159854-21143-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1412159854-21143-3-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone supports dma-coherent on USB master and also needs
dma-ranges to specify the hardware alias memory range in which DMA
can be operational.
Such configuration applied for USB0 devices, but It's missed for
USB1 device which is present only in K2E SoC - hence apply it.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2e.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
index 03d0190..0e25f79 100644
--- a/arch/arm/boot/dts/k2e.dtsi
+++ b/arch/arm/boot/dts/k2e.dtsi
@@ -67,6 +67,8 @@
 			clock-names = "usb";
 			interrupts = <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>;
 			ranges;
+			dma-coherent;
+			dma-ranges;
 			status = "disabled";
 
 			dwc3 at 25010000 {
-- 
1.9.1
