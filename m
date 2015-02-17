From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 17 Feb 2015 15:52:36 +0100
Subject: [PATCH v4 1/5] ARM: shmobile: sh73a0 dtsi: Add Bus State Controller
 node
In-Reply-To: <1424184760-1671-1-git-send-email-geert+renesas@glider.be>
References: <1424184760-1671-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1424184760-1671-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the Bus State Controller (BSC) on sh73a0, to which
multiple external devices can be connected.

The BSC is driven by the ZB clock, and located in PM domain A4S.
A reference to the latter will be added later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Claim compatiblity with "simple-pm-bus" instead of "simple-bus",

v3:
  - Move "ranges" before "reg",

v2:
  - Postpone power-domains.
---
 arch/arm/boot/dts/sh73a0.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index ab319b73e282d8b6..70b694f09fd5ef9e 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -376,6 +376,17 @@
 		status = "disabled";
 	};
 
+	bsc: bus at fec10000 {
+		compatible = "renesas,bsc-sh73a0", "renesas,bsc",
+			     "simple-pm-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x20000000>;
+		reg = <0xfec10000 0x400>;
+		interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&zb_clk>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
