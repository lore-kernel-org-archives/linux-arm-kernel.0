From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 19:44:56 -0500
Subject: [PATCH 2/2] ARM: dts: keystone: Add guestos maintenance interrupt
In-Reply-To: <1385253896-30241-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385253896-30241-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1385253896-30241-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Keystone gic device tree entry to add the maintenance
interrupt information.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index 00ce8f3..f6d6d9e 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -65,6 +65,8 @@
 		      <0x0 0x02562000 0x0 0x2000>,
 		      <0x0 0x02564000 0x0 0x1000>,
 		      <0x0 0x02566000 0x0 0x2000>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+				IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	timer {
-- 
1.7.9.5
