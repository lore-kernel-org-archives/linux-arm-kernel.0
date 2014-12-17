From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 17 Dec 2014 19:49:12 +0100
Subject: [PATCH 7/8] ARM: shmobile: r8a73a4 dtsi: Add Bus State Controller node
In-Reply-To: <1418842153-17113-1-git-send-email-geert+renesas@glider.be>
References: <1418842153-17113-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1418842153-17113-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the Bus State Controller (BSC) on r8a73a4, to which
multiple external devices can be connected.

The BSC is driven by the ZB clock, and located in PM domain C4.
A reference to the latter will be added later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested

v2:
  - New
---
 arch/arm/boot/dts/r8a73a4.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index d0b81bd64e439174..960a810456bd7e26 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -399,6 +399,15 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	bsc: bus at fec10000 {
+		compatible = "renesas,bsc-r8a73a4", "renesas,bsc", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0 0xfec10000 0 0x400>;
+		ranges = <0 0 0 0x20000000>;
+		clocks = <&zb_clk>;
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.9.1
