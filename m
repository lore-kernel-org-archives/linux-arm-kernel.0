From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 May 2014 22:04:24 -0300
Subject: [PATCH] ARM: dts: imx35-pdk: Fix memory region description
Message-ID: <1399943064-19031-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

On imx35pdk there are two DRAM chip selects that are used:
    
CS0 at 0x80000000
CS1 at 0x90000000
    
Each bank is connected to 128MB of DRAM, giving a total of 256MB of system DRAM.
   
Fix the memory layout to describe the hardware appropriately.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx35-pdk.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx35-pdk.dts b/arch/arm/boot/dts/imx35-pdk.dts
index db69ff0..8d71552 100644
--- a/arch/arm/boot/dts/imx35-pdk.dts
+++ b/arch/arm/boot/dts/imx35-pdk.dts
@@ -18,7 +18,8 @@
 	compatible = "fsl,imx35-pdk", "fsl,imx35";
 
 	memory {
-		reg = <0x80000000 0x8000000>;
+		reg = <0x80000000 0x8000000>,
+		      <0x90000000 0x8000000>;
 	};
 };
 
-- 
1.8.3.2
