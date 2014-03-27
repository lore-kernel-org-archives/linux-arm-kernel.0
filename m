From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Thu, 27 Mar 2014 09:26:53 +0000
Subject: [PATCH v6 07/10] ARM: shmobile: lager: Add PCIe device nodes
In-Reply-To: <1395912416-20087-1-git-send-email-phil.edworthy@renesas.com>
References: <1395912416-20087-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1395912416-20087-8-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

v6:
 - Split device and board DT changes
---
 arch/arm/boot/dts/r8a7790-lager.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index a55c5f8..bbbcb63 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -139,6 +139,16 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	clocks {
+		/* External PCIe bus clock - not used */
+		pcie_bus_clk: pcie_bus_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "pcie_bus";
+		};
+	};
 };
 
 &extal_clk {
-- 
1.9.0
