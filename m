From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue,  7 Jan 2014 19:57:13 +0100
Subject: [PATCH 1/4] ARM: shmobile: r8a7791: Add thermal clock in device tree
In-Reply-To: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389121036-3555-2-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add the missing thermal MSTP clock to the thermal device node.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/boot/dts/r8a7791.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d8dbf7e7b6a9..3233041d8a44 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -151,6 +151,7 @@
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks R8A7791_CLK_THERMAL>;
 	};
 
 	timer {
-- 
1.7.9.5
