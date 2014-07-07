From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:27 +0200
Subject: [PATCH v2 02/30] ARM: shmobile: r8a7778: Add SCIF nodes
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This describes all of the SCIF hardware of the r8a7778.
Each node is disabled and may be enabled as necessary
by board DTS files.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Added ack from Laurent Pinchart
* Removed interrupt-parent property from each new node
  as it is inherited from the top-level.
* Expanded changelog
---
 arch/arm/boot/dts/r8a7778.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 3af0a21..ecfdf4b 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -156,6 +156,48 @@
 		status = "disabled";
 	};
 
+	scif0: serial at ffe40000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe40000 0x100>;
+		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif1: serial at ffe41000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe41000 0x100>;
+		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif2: serial at ffe42000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe42000 0x100>;
+		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif3: serial at ffe43000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe43000 0x100>;
+		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif4: serial at ffe44000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe44000 0x100>;
+		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif5: serial at ffe45000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe45000 0x100>;
+		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	mmcif: mmc at ffe4e000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xffe4e000 0x100>;
-- 
2.0.0.rc2
