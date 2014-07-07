From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:30 +0200
Subject: [PATCH v2 05/30] ARM: shmobile: r8a7778: Add TMU nodes
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This describes all of the TMU hardware of the r8a7778.
Each node is disabled and may be enabled as necessary
by board DTS files.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Added ack from Laurent Pinchart
* Expanded changelog
---
 arch/arm/boot/dts/r8a7778.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index ecfdf4b..b5ea75e 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -156,6 +156,42 @@
 		status = "disabled";
 	};
 
+	tmu0: timer at ffd80000 {
+		compatible = "renesas,tmu";
+		reg = <0xffd80000 0x30>;
+		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
+	tmu1: timer at ffd81000 {
+		compatible = "renesas,tmu";
+		reg = <0xffd81000 0x30>;
+		interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
+	tmu2: timer at ffd82000 {
+		compatible = "renesas,tmu";
+		reg = <0xffd82000 0x30>;
+		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
 	scif0: serial at ffe40000 {
 		compatible = "renesas,scif-r8a7778", "renesas,scif";
 		reg = <0xffe40000 0x100>;
-- 
2.0.0.rc2
