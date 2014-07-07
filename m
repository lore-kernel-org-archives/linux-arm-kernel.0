From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:33 +0200
Subject: [PATCH v2 08/30] ARM: shmobile: r8a73a4: Add SCIF nodes
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This describes all of the SCIF hardware of the r8a73a4.
Each node is disabled and may be enabled as necessary
by board DTS files.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/boot/dts/r8a73a4.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 82c5ac8..d8ec505 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -252,6 +252,48 @@
 		status = "disabled";
 	};
 
+	scifa0: serial at e6c40000 {
+		compatible = "renesas,scifa-r8a73a4", "renesas,scifa";
+		reg = <0 0xe6c40000 0 0x100>;
+		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa1: serial at e6c50000 {
+		compatible = "renesas,scifa-r8a73a4", "renesas,scifa";
+		reg = <0 0xe6c50000 0 0x100>;
+		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifb2: serial at e6c20000 {
+		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
+		reg = <0 0xe6c20000 0 0x100>;
+		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifb3: serial at e6c30000 {
+		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
+		reg = <0 0xe6c30000 0 0x100>;
+		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifb4: serial at e6ce0000 {
+		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
+		reg = <0 0xe6ce0000 0 0x100>;
+		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifb5: serial at e6cf0000 {
+		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
+		reg = <0 0xe6cf0000 0 0x100>;
+		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	mmcif0: mmc at ee200000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
-- 
2.0.0.rc2
