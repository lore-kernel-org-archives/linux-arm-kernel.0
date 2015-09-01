From: shijie.huang@arm.com (Huang Shijie)
Date: Tue,  1 Sep 2015 09:41:23 +0800
Subject: [PATCH] arm64: dts: juno: replace the hardcode with the proper macros
Message-ID: <1441071683-3497-1-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old code uses hardcode for the memtimer's interrupt property,
this patch replaces the hardcode with the proper macros.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index e3ee960..ad0221a 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -12,7 +12,7 @@
 		status = "disabled";
 		frame at 2a830000 {
 			frame-number = <1>;
-			interrupts = <0 60 4>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0x2a830000 0x0 0x10000>;
 		};
 	};
-- 
2.1.4
