From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 May 2015 17:20:24 -0300
Subject: [PATCH] ARM: dts: imx6dl-wandboard: Do not hardcode memory size
Message-ID: <1431980424-11929-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx6dl-wandboard.dtb works for wandboard dual-lite and solo boards.

Wandboard dual-lite has 1 GB of RAM and wandboard solo has 512 MB, so
do not hardcode the memory size in the dts file and let the bootloader
pass the correct memory size instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6dl-wandboard.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dts b/arch/arm/boot/dts/imx6dl-wandboard.dts
index bbb6167..dcde3f6 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard.dts
@@ -15,8 +15,4 @@
 / {
 	model = "Wandboard i.MX6 Dual Lite Board";
 	compatible = "wand,imx6dl-wandboard", "fsl,imx6dl";
-
-	memory {
-		reg = <0x10000000 0x40000000>;
-	};
 };
-- 
1.9.1
