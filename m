From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 28 Mar 2014 02:09:13 -0300
Subject: [PATCH 1/2] ARM: dts: imx53-qsb-common: Fix memory region description
Message-ID: <1395983354-23196-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

On mx53qsb there are two DRAM chip selects:

CS0 at 0x70000000
CS1 at 0xb0000000

Each bank has a 512MB DRAM, giving a total of 1GB of system DRAM.

Fix the memory layout to describe the hardware appropriately.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx53-qsb-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index 2dca98b..d8ab280 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -14,7 +14,8 @@
 
 / {
 	memory {
-		reg = <0x70000000 0x40000000>;
+		reg = <0x70000000 0x20000000>,
+		      <0xb0000000 0x20000000>;
 	};
 
 	display at di0 {
-- 
1.8.3.2
