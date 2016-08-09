From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  9 Aug 2016 10:52:16 +0200
Subject: [PATCH 2/3] dt-bindings: mailbox: Add Amlogic Meson MHU Bindings
In-Reply-To: <1470732737-18391-1-git-send-email-narmstrong@baylibre.com>
References: <1470732737-18391-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1470732737-18391-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/mailbox/meson-mhu.txt      | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/meson-mhu.txt

diff --git a/Documentation/devicetree/bindings/mailbox/meson-mhu.txt b/Documentation/devicetree/bindings/mailbox/meson-mhu.txt
new file mode 100644
index 0000000..4a80b44
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/meson-mhu.txt
@@ -0,0 +1,33 @@
+Amlogic Meson MHU Mailbox Driver
+================================
+
+The Amlogic's Meson SoCs Message-Handling-Unit (MHU) is a mailbox controller
+that has 2 independent channels/links to communicate with remote processor(s).
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
+	mailbox: mailbox at c883c400 {
+		#mbox-cells = <1>;
+		compatible = "amlogic,meson-gxbb-mhu";
+		reg = <0 0xc883c400 0 0x4c>;
+		interrupts = <0 209 IRQ_TYPE_EDGE_RISING>,
+			   <0 210 IRQ_TYPE_EDGE_RISING>;
+		#mbox-cells = <1>;
+	};
-- 
2.7.0
