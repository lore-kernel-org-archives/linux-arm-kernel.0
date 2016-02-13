From: dhdang@apm.com (Duc Dang)
Date: Fri, 12 Feb 2016 19:39:27 -0800
Subject: [PATCH v6 2/3] Documentation: mailbox: Add APM X-Gene SLIMpro mailbox
 dts documentation
In-Reply-To: <cover.1455333720.git.dhdang@apm.com>
References: <cover.1455333720.git.dhdang@apm.com>
Message-ID: <4cf26966ebb6f5f41aab4e258984ac0600835748.1455333720.git.dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the APM X-Gene SLIMpro mailbox device tree
node documentation.

Signed-off-by: Feng Kan <fkan@apm.com>
Signed-off-by: Duc Dang <dhdang@apm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v5:
	- None

Changes since v4:
        - Rebase over v4.5-rc1
        - Fix number of total interrupts in
        introduction text
        - Change node name to mailbox at 10540000

Changes since v3:
        - Rebase over v4.4
        - Change number of mailbox IRQs to 8
        - Fix white spaces, typos.

 .../bindings/mailbox/xgene-slimpro-mailbox.txt     | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
new file mode 100644
index 0000000..e46451b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/xgene-slimpro-mailbox.txt
@@ -0,0 +1,35 @@
+The APM X-Gene SLIMpro mailbox is used to communicate messages between
+the ARM64 processors and the Cortex M3 (dubbed SLIMpro). It uses a simple
+interrupt based door bell mechanism and can exchange simple messages using the
+internal registers.
+
+There are total of 8 interrupts in this mailbox. Each used for an individual
+door bell (or mailbox channel).
+
+Required properties:
+- compatible:	Should be as "apm,xgene-slimpro-mbox".
+
+- reg:		Contains the mailbox register address range.
+
+- interrupts:	8 interrupts must be from 0 to 7, interrupt 0 define the
+		the interrupt for mailbox channel 0 and interrupt 1 for
+		mailbox channel 1 and so likewise for the reminder.
+
+- #mbox-cells:	only one to specify the mailbox channel number.
+
+Example:
+
+Mailbox Node:
+		mailbox: mailbox at 10540000 {
+			compatible = "apm,xgene-slimpro-mbox";
+			reg = <0x0 0x10540000 0x0 0xa000>;
+			#mbox-cells = <1>;
+			interrupts =  	<0x0 0x0 0x4>,
+					<0x0 0x1 0x4>,
+					<0x0 0x2 0x4>,
+					<0x0 0x3 0x4>,
+					<0x0 0x4 0x4>,
+					<0x0 0x5 0x4>,
+					<0x0 0x6 0x4>,
+					<0x0 0x7 0x4>,
+		};
-- 
1.9.1
