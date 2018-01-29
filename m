From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 29 Jan 2018 16:07:21 -0500
Subject: [PATCH] arm64: dts: Add DPAA QBMan portal 9
Message-ID: <1517260041-19300-1-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM DPAA1 (LS1043 and LS1046) have 10 QBMan portals (indexed 0-9)
Enable the one that is missing in the device trees.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 arch/arm64/boot/dts/freescale/qoriq-bman-portals.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/qoriq-qman-portals.dtsi | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/qoriq-bman-portals.dtsi b/arch/arm64/boot/dts/freescale/qoriq-bman-portals.dtsi
index c3c2be4..ae15307 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-bman-portals.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-bman-portals.dtsi
@@ -68,4 +68,10 @@
 		reg = <0x80000 0x4000>, <0x4080000 0x4000>;
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	bman-portal at 90000 {
+		compatible = "fsl,bman-portal";
+		reg = <0x90000 0x4000>, <0x4090000 0x4000>;
+		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
diff --git a/arch/arm64/boot/dts/freescale/qoriq-qman-portals.dtsi b/arch/arm64/boot/dts/freescale/qoriq-qman-portals.dtsi
index 2a9aa06..6a93a4a 100644
--- a/arch/arm64/boot/dts/freescale/qoriq-qman-portals.dtsi
+++ b/arch/arm64/boot/dts/freescale/qoriq-qman-portals.dtsi
@@ -77,4 +77,11 @@
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		cell-index = <8>;
 	};
+
+	qportal9: qman-portal at 90000 {
+		compatible = "fsl,qman-portal";
+		reg = <0x90000 0x4000>, <0x4090000 0x4000>;
+		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+		cell-index = <9>;
+	};
 };
-- 
2.7.4
