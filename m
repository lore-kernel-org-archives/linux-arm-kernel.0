From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 30 Sep 2015 14:39:47 +0800
Subject: [PATCH v2 3/3] ARM: dts: sun6i: hummingbird: Drop AXP221 DC1SW and
 DC5LDO supplies
In-Reply-To: <1443595188-1283-1-git-send-email-wens@csie.org>
References: <1443595188-1283-1-git-send-email-wens@csie.org>
Message-ID: <1443595188-1283-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"dcdc1-supply" and "dcdc5-supply" have been dropped, as they are
internally connected and should not be represented in the device
tree.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 06d9391ca30e..f93cf4c42a7a 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -178,8 +178,6 @@
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		dcdc1-supply = <&vcc_3v0>;
-		dcdc5-supply = <&vcc_dram>;
 
 		regulators {
 			x-powers,dcdc-freq = <3000>;
-- 
2.5.3
