From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Fri, 09 Jun 2017 20:17:47 +0900
Subject: [PATCH v2] ARM: dts: rv1108: change to "max-frequency" from
 "clock-freq-min-max"
References: <CGME20170609111748epcas5p163d65c6bd94776383381d80b632414a5@epcas5p1.samsung.com>
Message-ID: <20170609111747.24591-1-jh80.chung@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"clock-freq-min-max" was deprecated. There is only using in rv1108.dtsi.
Use the "max-frequency" for removiing "clock-freq-min-max" in future.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog on V2:
- Rebased on Heiko's git repository (v4.13-armsoc/dts32 branch)

 arch/arm/boot/dts/rv1108.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 437098b..6a3da2d 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -174,7 +174,7 @@
 
 	emmc: dwmmc at 30110000 {
 		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
-		clock-freq-min-max = <400000 150000000>;
+		max-frequency = <150000000>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
@@ -186,7 +186,7 @@
 
 	sdio: dwmmc at 30120000 {
 		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
-		clock-freq-min-max = <400000 150000000>;
+		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
@@ -198,7 +198,7 @@
 
 	sdmmc: dwmmc at 30130000 {
 		compatible = "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc";
-		clock-freq-min-max = <400000 100000000>;
+		max-frequency = <100000000>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-- 
2.10.2
