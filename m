From: peter@korsgaard.com (Peter Korsgaard)
Date: Fri, 16 Jun 2017 14:39:57 +0200
Subject: [PATCH] ARM: dts: kirkwood: Fix Openblock A6 nand partition overlap
Message-ID: <20170616123957.17111-1-peter@korsgaard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "test" and "conf" nand partitions partly overlap:

Creating 6 MTD partitions on "orion_nand":
0x000000000000-0x000000090000 : "uboot"
0x000000090000-0x0000000d4000 : "env"
0x0000000d4000-0x0000000f8000 : "test"
0x0000000f4000-0x0000004f4000 : "conf"

That is unlikely to be desired, and not matching the partition map used in
u-boot - So adjust the test partition size to fix this.

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 94e49f32d5f9..c75da5f0ca48 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -141,7 +141,7 @@
 
 	partition at d4000 {
 		label = "test";
-		reg = <0xd4000 0x24000>;
+		reg = <0xd4000 0x20000>;
 	};
 
 	partition at f4000 {
-- 
2.11.0
