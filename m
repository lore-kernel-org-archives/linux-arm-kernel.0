From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:31:48 +0100
Subject: [PATCH 02/63] ARM: ux500: Setup the DMA40 driver's DT node using the
 new DMA API
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new DMA is now available, so let's use it to setup ST-Ericsson's
DMA40 driver when Device Tree is enabled.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 0f462b7..8a82b18 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -182,12 +182,13 @@
 			interrupts = <0 23 0x4>;
 		};
 
-		dma-controller at 801C0000 {
-			compatible = "stericsson,db8500-dma40",
-					"stericsson,dma40";
+		dma: dma-controller at 801C0000 {
+			compatible = "stericsson,db8500-dma40", "stericsson,dma40";
 			reg = <0x801C0000 0x1000 0x40010000 0x800>;
 			reg-names = "base", "lcpa";
 			interrupts = <0 25 0x4>;
+
+			#dma-cells = <3>;
 		};
 
 		prcmu: prcmu at 80157000 {
-- 
1.7.10.4
