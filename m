From: york.sun@nxp.com (York Sun)
Date: Thu, 4 Aug 2016 15:58:36 -0700
Subject: [Patch v3 11/11] arm64: Update device tree for Layerscape SoCs
In-Reply-To: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
References: <1470351518-22404-1-git-send-email-york.sun@nxp.com>
Message-ID: <1470351518-22404-12-git-send-email-york.sun@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DDR memory controller nodes to enable EDAC driver.

Signed-off-by: York Sun <york.sun@nxp.com>

---
Change log
  v3: no change
  v2: no change

 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  7 +++++++
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index de0323b..cb33f23 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -196,6 +196,13 @@
 			bus-width = <4>;
 		};
 
+		ddr: memory-controller at 1080000 {
+			compatible = "fsl,qoriq-memory-controller";
+			reg = <0x0 0x1080000 0x0 0x1000>;
+			interrupts = <0 144 0x4>;
+			big-endian;
+		};
+
 		dspi0: dspi at 2100000 {
 			compatible = "fsl,ls1043a-dspi", "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 3187c82..3221e5c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -689,4 +689,18 @@
 			interrupts = <0 12 4>;
 		};
 	};
+
+	ddr1: memory-controller at 1080000 {
+		compatible = "fsl,qoriq-memory-controller";
+		reg = <0x0 0x1080000 0x0 0x1000>;
+		interrupts = <0 17 0x4>;
+		little-endian;
+	};
+
+	ddr2: memory-controller at 1090000 {
+		compatible = "fsl,qoriq-memory-controller";
+		reg = <0x0 0x1090000 0x0 0x1000>;
+		interrupts = <0 18 0x4>;
+		little-endian;
+	};
 };
-- 
2.7.4
