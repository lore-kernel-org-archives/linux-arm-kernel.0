From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 1 Aug 2013 17:37:45 +0800
Subject: [PATCH V3] ARM: dts: tegra114: dalmore: fix the irq trigger type of
 Palmas MFD device
Message-ID: <1375349865-29816-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ trigger type of Palmas MFD device (tps65913) is designed as
low-level sensitive on Dalmore. The wrong configuration would cause an
interrupt storm when booting the system. Fixing it in DT with appropriate
interrupt type.

Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 2bfeb89..b5a42f0 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -840,7 +840,7 @@
 		palmas: tps65913 {
 			compatible = "ti,palmas";
 			reg = <0x58>;
-			interrupts = <0 86 0x4>;
+			interrupts = <0 86 IRQ_TYPE_LEVEL_LOW>;
 
 			#interrupt-cells = <2>;
 			interrupt-controller;
-- 
1.8.3.4
