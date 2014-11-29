From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Sat, 29 Nov 2014 21:14:10 +0100
Subject: [PATCH v3 1/3] Documentation: dt: add Altera L3 NIC bindings
In-Reply-To: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1417292052-12974-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1417292052-12974-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation for the Altera L3 networked interconnect found on the
SoCFPGA architecture.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 .../devicetree/bindings/soc/socfpga/altr,l3-nic.txt       | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socfpga/altr,l3-nic.txt

diff --git a/Documentation/devicetree/bindings/soc/socfpga/altr,l3-nic.txt b/Documentation/devicetree/bindings/soc/socfpga/altr,l3-nic.txt
new file mode 100644
index 000000000000..d9491f14eed3
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socfpga/altr,l3-nic.txt
@@ -0,0 +1,15 @@
+Altera SOCFPGA L3 Network Interconnect
+--------------------------------------
+
+The L3 NIC provides access to Global Programmer View (GPV) registers for all
+AXI slaves and masters on the SoC.
+
+Required properties:
+- compatible : "altr,l3-nic"
+- reg : Should contain 1 register range (address and length)
+
+Example:
+	 gpv at ff800000 {
+		compatible = "altr,l3-nic";
+		reg = <0xff800000 0x100000>;
+	};
-- 
2.1.3
