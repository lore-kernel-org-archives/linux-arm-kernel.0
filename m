From: robin.murphy@arm.com (Robin Murphy)
Date: Thu,  7 Jan 2016 12:01:59 +0000
Subject: [PATCH] arm64/dts: Add missing DMA Abort interrupt to Juno
Message-ID: <6a66d2ac442925e066fe9b67ee2883de5894b0d3.1452168063.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DMA-330 has an "irq_abort" interrupt line on which it signals faults
separately from the "irq[n:0]" channel interrupts. On Juno, this is
wired up to SPI 92; add it to the DT so that DMAC faults are correctly
reported for the driver to reset the thing, rather than leaving it
locked up and waiting to time out.

CC: Liviu Dudau <liviu.dudau@arm.com>
CC: Sudeep Holla <sudeep.holla@arm.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index dd5158e..e5b59ca 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -115,6 +115,7 @@
 			     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-- 
1.9.1
