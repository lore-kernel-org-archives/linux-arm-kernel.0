From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:27 +0900
Subject: [PATCH 11/13] ARM: shmobile: marzen: fixup SMSC IRQ number on DTS
In-Reply-To: <cover.1381298964.git.horms+renesas@verge.net.au>
References: <cover.1381298964.git.horms+renesas@verge.net.au>
Message-ID: <bffdd7d1a4249dddf1ded81e412cf3c78d139e38.1381298964.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch fixup miss-setting of SMSC IRQ number.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 6d55083..ab4110a 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -42,8 +42,8 @@
 		pinctrl-names = "default";
 
 		phy-mode = "mii";
-		interrupt-parent = <&gic>;
-		interrupts = <0 28 0x4>;
+		interrupt-parent = <&irqpin0>;
+		interrupts = <1 0>; /* IRQ1: hwirq 1 on irqpin0 */
 		reg-io-width = <4>;
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
@@ -63,6 +63,10 @@
 	};
 };
 
+&irqpin0 {
+	status = "okay";
+};
+
 &pfc {
 	pinctrl-0 = <&scif2_pins &scif4_pins &sdhi0_pins>;
 	pinctrl-names = "default";
-- 
1.8.4
