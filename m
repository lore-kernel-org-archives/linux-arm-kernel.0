From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:28:21 +0900
Subject: [PATCH 12/29] ARM: shmobile: lager: Move i2c[12]_pins nodes to pfc
 node
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
Message-ID: <d90bf60ceaf453b59c8cd5dbfa59538e27255706.1403487225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to an error when resolving conflicts df40f256b18300e1 ("ARM: shmobile:
lager: add i2c1, i2c2 pins") added the i2c[12]_pins nodes to the wrong
node.

This patch moves them to their correct location in the pfc node.

Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 3297b86a..b68ff56 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -144,16 +144,6 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
-
-	i2c1_pins: i2c1 {
-		renesas,groups = "i2c1";
-		renesas,function = "i2c1";
-	};
-
-	i2c2_pins: i2c2 {
-		renesas,groups = "i2c2";
-		renesas,function = "i2c2";
-	};
 };
 
 &extal_clk {
@@ -215,6 +205,16 @@
 		renesas,function = "msiof1";
 	};
 
+	i2c1_pins: i2c1 {
+		renesas,groups = "i2c1";
+		renesas,function = "i2c1";
+	};
+
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
+
 	i2c3_pins: i2c3 {
 		renesas,groups = "i2c3";
 		renesas,function = "i2c3";
-- 
2.0.0.rc2
