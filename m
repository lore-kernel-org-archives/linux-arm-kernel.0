From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:44 +0200
Subject: [PATCH v2 19/30] ARM: shmobile: r8a7740: Add TMU nodes
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-20-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This describes all of the TMU hardware of the r8a7740.
Each node is disabled and may be enabled as necessary
by board DTS files.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/boot/dts/r8a7740.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index bda18fb..3156afd 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -236,6 +236,30 @@
 			<&irqpin3 4 0>, <&irqpin3 5 0>, <&irqpin3 6 0>, <&irqpin3 7 0>;
 	};
 
+	tmu0: timer at fff80000 {
+		compatible = "renesas,tmu";
+		reg = <0xfff80000 0x2c>;
+		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 199 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 200 IRQ_TYPE_LEVEL_HIGH>;
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
+	tmu1: timer at fff90000 {
+		compatible = "renesas,tmu";
+		reg = <0xfff90000 0x2c>;
+		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 171 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 172 IRQ_TYPE_LEVEL_HIGH>;
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
 	tpu: pwm at e6600000 {
 		compatible = "renesas,tpu-r8a7740", "renesas,tpu";
 		reg = <0xe6600000 0x100>;
-- 
2.0.0.rc2
