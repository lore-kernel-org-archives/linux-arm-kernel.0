From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:05:01 +0900
Subject: [PATCH 3/3] ARM: shmobile: r8a7790: fix shdi resource sizes
In-Reply-To: <cover.1387856124.git.horms+renesas@verge.net.au>
References: <cover.1387856124.git.horms+renesas@verge.net.au>
Message-ID: <d721a15c300c5f638a11573a6dd492158e737d6a.1387856124.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

The r8a7790.dtsi file has four sdhi nodes which the first two have the wrong
resource size for their register block. This causes the sh_modbile_sdhi driver
to fail to communicate with card at-all.

Change sdhi{0,1} node size from 0x100 to 0x200 to correct these nodes
as per Kuninori Morimoto's response to the original patch where all four
nodes where changed. sdhi{2,3} are the correct size.

This bug has been present since sdhi resources were added to the r8a7790 by
8c9b1aa41853272a ("ARM: shmobile: r8a7790: add MMCIF and SDHI DT
templates") in v3.11-rc2.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Tested-by: William Towle <william.towle@codethink.co.uk>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 46e1d7e..9987dd0e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -241,7 +241,7 @@
 
 	sdhi0: sdhi at ee100000 {
 		compatible = "renesas,sdhi-r8a7790";
-		reg = <0 0xee100000 0 0x100>;
+		reg = <0 0xee100000 0 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 165 4>;
 		cap-sd-highspeed;
@@ -250,7 +250,7 @@
 
 	sdhi1: sdhi at ee120000 {
 		compatible = "renesas,sdhi-r8a7790";
-		reg = <0 0xee120000 0 0x100>;
+		reg = <0 0xee120000 0 0x200>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 166 4>;
 		cap-sd-highspeed;
-- 
1.8.4
