From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 31 Mar 2014 11:30:54 +0100
Subject: [PATCH v7 09/10] ARM: shmobile: koelsch: Add PCIe device nodes
In-Reply-To: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
References: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1396261856-22465-10-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

v6:
 - Split device and board DT changes
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index ee23b7b..3130a0c 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -204,6 +204,16 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	clocks {
+		/* External PCIe bus clock */
+		pcie_bus_clk: pcie_bus_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <100000000>;
+			clock-output-names = "pcie_bus";
+		};
+	};
 };
 
 &extal_clk {
@@ -382,3 +392,7 @@
 		spi-cpha;
 	};
 };
+
+&pcie {
+	status = "okay";
+};
-- 
1.9.0
