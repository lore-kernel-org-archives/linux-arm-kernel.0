From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 16:33:22 +0900
Subject: [PATCH v3 06/20] ARM: shmobile: marzen: Specify external clock
 frequency in DT
In-Reply-To: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1393400016-23433-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The external crystal frequency is 31.25 on the Marzen board.
Specify it in the device tree.

Based on work for the Lager board by Laurent Pinchart.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v3
* Update r8a7779-marzen.dts instead of r8a7779-marzen-reference.dts
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index eda6240..2c727cd 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -68,6 +68,10 @@
 	status = "okay";
 };
 
+&extal_clk {
+	clock-frequency = <31250000>;
+};
+
 &pfc {
 	pinctrl-0 = <&scif2_pins &scif4_pins>;
 	pinctrl-names = "default";
-- 
1.8.5.2
