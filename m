From: julien.chauveau@neo-technologies.fr (Julien CHAUVEAU)
Date: Fri, 28 Nov 2014 11:24:14 +0100
Subject: [PATCH] ARM: dts: rockchip: set FIFO size for SDMMC, SDIO and EMMC
Message-ID: <1417170254-13615-1-git-send-email-julien.chauveau@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SDMMC, SDIO and EMMC controllers use an external FIFO whose size is 256x32bit.
This patch set the corresponding fifo-depth properties for both RK3066 and RK3188.

Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 87df6a8..c54a971 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -177,10 +177,9 @@
 		compatible = "rockchip,rk2928-dw-mshc";
 		reg = <0x10214000 0x1000>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>;
 		clock-names = "biu", "ciu";
-
+		fifo-depth = <256>;
 		status = "disabled";
 	};
 
@@ -188,10 +187,9 @@
 		compatible = "rockchip,rk2928-dw-mshc";
 		reg = <0x10218000 0x1000>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>;
 		clock-names = "biu", "ciu";
-
+		fifo-depth = <256>;
 		status = "disabled";
 	};
 
@@ -199,10 +197,9 @@
 		compatible = "rockchip,rk2928-dw-mshc";
 		reg = <0x1021c000 0x1000>;
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>;
 		clock-names = "biu", "ciu";
-
+		fifo-depth = <256>;
 		status = "disabled";
 	};
 
-- 
2.1.0
