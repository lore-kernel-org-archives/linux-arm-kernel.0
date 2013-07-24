From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 24 Jul 2013 18:54:32 +0800
Subject: [PATCH V2] ARM: dts: tegra114: dalmore: fix the irq trigger type of
 Palmas MFD device
Message-ID: <1374663272-9937-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ trigger type of Palmas MFD device (tps65913) is edge trigger. The
wrong configuration would cause an interrupt storm when booting the
system. Fixing it in DT with appropriate interrupt type.

Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 76529e4..a2a1b5f 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -840,7 +840,7 @@
 		palmas: tps65913 {
 			compatible = "ti,palmas";
 			reg = <0x58>;
-			interrupts = <0 86 0x4>;
+			interrupts = <0 86 0x0>;
 
 			#interrupt-cells = <2>;
 			interrupt-controller;
-- 
1.8.3.2
