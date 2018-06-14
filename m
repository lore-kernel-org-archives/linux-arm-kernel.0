From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 14 Jun 2018 22:19:58 +0300
Subject: [PATCH v2 2/2] arm64: dts: renesas: condor: add PCIe support
In-Reply-To: <b37d458c-071a-833a-2057-be8a07c880be@cogentembedded.com>
References: <b37d458c-071a-833a-2057-be8a07c880be@cogentembedded.com>
Message-ID: <eba72bac-60f8-2c09-e3e7-4b6a73e5fdfa@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PCIe PHY and PCIEC and specify the PCIe bus clock for the Condor
board.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- mentioned Vladimir's original work and added his signoff;
- refreshed the patch.

 arch/arm64/boot/dts/renesas/r8a77980-condor.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -223,6 +223,18 @@
 	status = "okay";
 };
 
+&pciec {
+	status = "okay";
+};
+
+&pcie_bus_clk {
+	clock-frequency = <100000000>;
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
 &pfc {
 	avb_pins: avb {
 		groups = "avb_mdio", "avb_rgmii";
