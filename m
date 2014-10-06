From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  6 Oct 2014 14:38:07 +0200
Subject: [PATCH v3 2/2] ARM: zynq: DT: Add OCM controller node
In-Reply-To: <e65e39088e0f571ee4905172f2f6c84dbc037805.1412599051.git.michal.simek@xilinx.com>
References: <e65e39088e0f571ee4905172f2f6c84dbc037805.1412599051.git.michal.simek@xilinx.com>
Message-ID: <1b10d4e509caac663966788cd2df10120496eb1e.1412599051.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the on-chip-memory controller node to the Zynq devicetree.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- Extract from OCM driver

Changes in v2: None

 arch/arm/boot/dts/zynq-7000.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 6cc83d4c6c76..b8e87d615635 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -146,6 +146,13 @@
 			cache-level = <2>;
 		};

+		ocmc: ocmc at f800c000 {
+			compatible = "xlnx,zynq-ocmc-1.0";
+			interrupt-parent = <&intc>;
+			interrupts = <0 3 4>;
+			reg = <0xf800c000 0x1000>;
+		} ;
+
 		uart0: serial at e0000000 {
 			compatible = "xlnx,xuartps", "cdns,uart-r1p8";
 			status = "disabled";
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/da89f2ab/attachment-0001.sig>
