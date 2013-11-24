From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 19:44:55 -0500
Subject: [PATCH 1/2] ARM: dts: keystone: Add the GICV and GICH address space
In-Reply-To: <1385253896-30241-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385253896-30241-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1385253896-30241-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Keystone gic node to add the GICV and GIGH address space
needed by the KVM.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/keystone.dtsi |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index c01c6fb..00ce8f3 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -62,7 +62,9 @@
 		#address-cells = <1>;
 		interrupt-controller;
 		reg = <0x0 0x02561000 0x0 0x1000>,
-		      <0x0 0x02562000 0x0 0x2000>;
+		      <0x0 0x02562000 0x0 0x2000>,
+		      <0x0 0x02564000 0x0 0x1000>,
+		      <0x0 0x02566000 0x0 0x2000>;
 	};
 
 	timer {
-- 
1.7.9.5
