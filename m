From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 24 Sep 2018 11:46:48 +0200
Subject: [PATCH] arm64: amd: seattle: Use "spi" as name for SPI controllers
Message-ID: <20180924094648.20797-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Recent versions of DTC contain additional checks for SPI busses and warn
about certain common mistakes, such as when an SPI controller has a name
other than "spi".

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 125f4deb52fe..b664e7af74eb 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -107,7 +107,7 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		spi0: ssp at e1020000 {
+		spi0: spi at e1020000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0 0xe1020000 0 0x1000>;
@@ -117,7 +117,7 @@
 			clock-names = "apb_pclk";
 		};
 
-		spi1: ssp at e1030000 {
+		spi1: spi at e1030000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0 0xe1030000 0 0x1000>;
-- 
2.19.0
