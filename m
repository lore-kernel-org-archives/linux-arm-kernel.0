From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 14 Jun 2018 13:56:03 +1000
Subject: [PATCH 1/3] arm: dts: Fix error in Aspeed OpenPower Romulus
 device-tree
Message-ID: <20180614035605.25286-1-benh@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reserved memory for the VGA frame buffer is at the wrong address
for this system.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
---
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index 0b9b37d4d6ef..7d28c03a9e0b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -21,9 +21,9 @@
 		#size-cells = <1>;
 		ranges;
 
-		vga_memory: framebuffer at bf000000 {
+		vga_memory: framebuffer at 9f000000 {
 			no-map;
-			reg = <0xbf000000 0x01000000>; /* 16M */
+			reg = <0x9f000000 0x01000000>; /* 16M */
 		};
 
 		flash_memory: region at 98000000 {
-- 
2.17.0
