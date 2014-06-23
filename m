From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:28:20 +0900
Subject: [PATCH 11/29] ARM: shmobile: lager: add i2c1, i2c2 pins
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
Message-ID: <e1a2c4eb132018ce5b988c9ff5ba7a01e5494af5.1403487225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Add pinctrl definitions for i2c1 and i2c2 busses on the Lager board
to ensure these are setup correctly at initialisation time. The i2c0
and i2c3 busses are connected to single function pins.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[horms+renesas at verge.net.au: Added shmobile to patch title]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index bd92dcf..3297b86a 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -144,6 +144,16 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	i2c1_pins: i2c1 {
+		renesas,groups = "i2c1";
+		renesas,function = "i2c1";
+	};
+
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
 };
 
 &extal_clk {
@@ -349,10 +359,14 @@
 
 &i2c1	{
 	status = "ok";
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
 };
 
 &i2c2	{
 	status = "ok";
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
 };
 
 &i2c3	{
-- 
2.0.0.rc2
