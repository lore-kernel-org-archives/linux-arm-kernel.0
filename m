From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 28 Mar 2014 02:09:14 -0300
Subject: [PATCH 2/2] ARM: dts: imx53-m53evk: Fix memory region description
In-Reply-To: <1395983354-23196-1-git-send-email-festevam@gmail.com>
References: <1395983354-23196-1-git-send-email-festevam@gmail.com>
Message-ID: <1395983354-23196-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

On m53evk there are two DRAM chip selects:

CS0 at 0x70000000
CS1 at 0xb0000000

Each bank has a 512MB DRAM, giving a total of 1GB of system DRAM.

Fix the memory layout to describe the hardware appropriately.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx53-m53evk.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index e8d11e2..537d7f3 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -17,7 +17,8 @@
 	compatible = "denx,imx53-m53evk", "fsl,imx53";
 
 	memory {
-		reg = <0x70000000 0x20000000>;
+		reg = <0x70000000 0x20000000>,
+		      <0xb0000000 0x20000000>;
 	};
 
 	soc {
-- 
1.8.3.2
