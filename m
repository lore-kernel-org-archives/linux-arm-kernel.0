From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 14 Nov 2014 11:52:07 +0100
Subject: [PATCH v4 6/6] ARM: zynq: DT: Add OCM controller node
In-Reply-To: <cover.1415962281.git.michal.simek@xilinx.com>
References: <cover.1415962281.git.michal.simek@xilinx.com>
Message-ID: <0a88d52b5e71fb220ca619180ec9ca746edad2b1.1415962281.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the on-chip-memory controller node to the Zynq devicetree.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v4:
- Use memory-controller at ... instead of ocmc at ...

Changes in v3:
- Extract from OCM driver

Changes in v2: None

 arch/arm/boot/dts/zynq-7000.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index ce2ef5bec4f2..e217fb1c1169 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -150,6 +150,13 @@
 			reg = <0xf8006000 0x1000>;
 		};

+		ocmc: memory-controller at f800c000 {
+			compatible = "xlnx,zynq-ocmc-1.0";
+			interrupt-parent = <&intc>;
+			interrupts = <0 3 4>;
+			reg = <0xf800c000 0x1000>;
+		};
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/85f332b2/attachment.sig>
