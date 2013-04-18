From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:12:07 +0100
Subject: [PATCH 25/32] ARM: ux500: Setup the DMA40 driver's DT node using the
 new DMA API
In-Reply-To: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366279934-30761-26-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new DMA is now available, so let's use it to setup ST-Ericsson's
DMA40 driver when Device Tree is enabled.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 0f462b7..e2fa20f 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -182,12 +182,14 @@
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
+			dma-channels = <0>; /* Zero means read from H/W. */
 		};
 
 		prcmu: prcmu at 80157000 {
-- 
1.7.10.4
