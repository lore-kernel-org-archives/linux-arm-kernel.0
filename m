From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:17 +0900
Subject: [PATCH 07/13] ARM: shmobile: r8a7791 Arch timer device tree node
In-Reply-To: <cover.1381298964.git.horms+renesas@verge.net.au>
References: <cover.1381298964.git.horms+renesas@verge.net.au>
Message-ID: <03586acf7808ed65963cd262188b059ff6951d40.1381298964.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add r8a7791 arch timer device tree information.

This needs to be used together with r8a7791 support
code that ties in the R-Car Gen2 arch timer workarounds.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index b701417..a1a9e5c 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -39,6 +39,14 @@
 		interrupts = <1 9 0xf04>;
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <1 13 0xf08>,
+				<1 14 0xf08>,
+				<1 11 0xf08>,
+				<1 10 0xf08>;
+	};
+
 	irqc0: interrupt-controller at e61c0000 {
 		compatible = "renesas,irqc";
 		#interrupt-cells = <2>;
-- 
1.8.4
