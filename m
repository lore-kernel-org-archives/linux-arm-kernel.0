From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 17 Feb 2015 16:04:41 +0100
Subject: [PATCH v4 1/6] ARM: shmobile: r8a73a4 dtsi: Add Bus State Controller
 node
In-Reply-To: <1424185486-3017-1-git-send-email-geert+renesas@glider.be>
References: <1424185486-3017-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1424185486-3017-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the Bus State Controller (BSC) on r8a73a4, to which
multiple external devices can be connected.

The BSC is driven by the ZB clock, and located in PM domain C4.
A reference to the latter will be added later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v4:
  - Add Acked-by,
  - Claim compatiblity with "simple-pm-bus" instead of "simple-bus",

v3:
  - Add Tested-by,
  - Move "ranges" before "reg",

v2:
  - New.
---
 arch/arm/boot/dts/r8a73a4.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index fdcca5d0fb61f0bc..77bd35cd89113df7 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -409,6 +409,16 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	bsc: bus at fec10000 {
+		compatible = "renesas,bsc-r8a73a4", "renesas,bsc",
+			     "simple-pm-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0x20000000>;
+		reg = <0 0xfec10000 0 0x400>;
+		clocks = <&zb_clk>;
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.9.1
