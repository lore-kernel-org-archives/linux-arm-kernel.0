From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 27 Aug 2018 21:54:35 +0300
Subject: [PATCH v3 2/2] arm64: dts: renesas: condor: add PCIe support
In-Reply-To: <fb4eb097-40aa-82df-68c7-9b727c858a8b@cogentembedded.com>
References: <fb4eb097-40aa-82df-68c7-9b727c858a8b@cogentembedded.com>
Message-ID: <259d65c0-5fb8-e426-3452-c5109a687c15@cogentembedded.com>
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
