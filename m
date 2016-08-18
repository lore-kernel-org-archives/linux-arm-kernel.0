From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:10:26 +0200
Subject: [PATCH v2 2/3] dt-bindings: mailbox: Add Amlogic Meson MHU Bindings
In-Reply-To: <1471515027-3543-1-git-send-email-narmstrong@baylibre.com>
References: <1471515027-3543-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471515027-3543-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/mailbox/meson-mhu.txt      | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/meson-mhu.txt

diff --git a/Documentation/devicetree/bindings/mailbox/meson-mhu.txt b/Documentation/devicetree/bindings/mailbox/meson-mhu.txt
new file mode 100644
index 0000000..a530310
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/meson-mhu.txt
@@ -0,0 +1,34 @@
+Amlogic Meson MHU Mailbox Driver
+================================
+
+The Amlogic's Meson SoCs Message-Handling-Unit (MHU) is a mailbox controller
+that has 3 independent channels/links to communicate with remote processor(s).
+MHU links are hardwired on a platform. A link raises interrupt for any
+received data. However, there is no specified way of knowing if the sent
+data has been read by the remote. This driver assumes the sender polls
+STAT register and the remote clears it after having read the data.
+
+Mailbox Device Node:
+====================
+
+Required properties:
+--------------------
+- compatible:		Shall be "amlogic,meson-gxbb-mhu"
+- reg:			Contains the mailbox register address range (base
+			address and length)
+- #mbox-cells		Shall be 1 - the index of the channel needed.
+- interrupts:		Contains the interrupt information corresponding to
+			each of the 2 links of MHU.
+
+Example:
+--------
+
+	mailbox: mailbox at c883c404 {
+		#mbox-cells = <1>;
+		compatible = "amlogic,meson-gxbb-mhu";
+		reg = <0 0xc883c404 0 0x4c>;
+		interrupts = <0 208 IRQ_TYPE_EDGE_RISING>,
+			     <0 209 IRQ_TYPE_EDGE_RISING>,
+			     <0 210 IRQ_TYPE_EDGE_RISING>;
+		#mbox-cells = <1>;
+	};
-- 
1.9.1
