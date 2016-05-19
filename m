From: vigneshr@ti.com (Vignesh R)
Date: Thu, 19 May 2016 12:17:30 +0530
Subject: [PATCH 2/2] ARM: dts: am335x-icev2: Add DT node for TI PCA9536
In-Reply-To: <1463640450-16762-1-git-send-email-vigneshr@ti.com>
References: <1463640450-16762-1-git-send-email-vigneshr@ti.com>
Message-ID: <1463640450-16762-3-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM335x ICE board has a TI PCA9536 chip connected to I2C0 at address
0x41. Add DT entry for the same.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/am335x-icev2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index e271013e78a6..7d8b8fefdf08 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -206,6 +206,13 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	pca9536: gpio at 41 {
+		compatible = "ti,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 #include "tps65910.dtsi"
-- 
2.8.2
