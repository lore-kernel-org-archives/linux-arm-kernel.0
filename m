From: scottwood@freescale.com (Scott Wood)
Date: Tue, 15 Sep 2015 18:54:32 -0500
Subject: [PATCH v2] arm64: dts: fsl-ls2080a: Add serial aliases
Message-ID: <20150915235432.GA26825@home.buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These will allow U-Boot to set linux,stdout-path in /chosen based on
the active console device, which will allow devicetree-based earlycon.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: Put aliases in board dts rather than chip dtsi

Depends on https://patchwork.kernel.org/patch/7120211/

 arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts  | 5 +++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts  | 5 +++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
index 116b7c2..437dd25 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dts
@@ -51,6 +51,11 @@
 / {
 	model = "Freescale Layerscape 2080a QDS Board";
 	compatible = "fsl,ls2080a-qds", "fsl,ls2080a";
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+	};
 };
 
 &esdhc {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
index 2858da7..6be14b5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
@@ -51,6 +51,11 @@
 / {
 	model = "Freescale Layerscape 2080a RDB Board";
 	compatible = "fsl,ls2080a-rdb", "fsl,ls2080a";
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+	};
 };
 
 &esdhc {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
index cf45d38..21a07a0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-simu.dts
@@ -57,6 +57,11 @@
 	model = "Freescale Layerscape 2080a software Simulator model";
 	compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
 
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+	};
+
 	ethernet at 2210000 {
 		compatible = "smsc,lan91c111";
 		reg = <0x0 0x2210000 0x0 0x100>;
-- 
2.1.4
