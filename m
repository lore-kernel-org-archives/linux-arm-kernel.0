From: anup.patel@broadcom.com (Anup Patel)
Date: Mon, 15 May 2017 10:34:55 +0530
Subject: [PATCH v8 4/4] dt-bindings: Add DT bindings document for Broadcom SBA
 RAID driver
In-Reply-To: <1494824695-21797-1-git-send-email-anup.patel@broadcom.com>
References: <1494824695-21797-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1494824695-21797-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the DT bindings document for newly added Broadcom
SBA RAID driver.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 .../devicetree/bindings/dma/brcm,iproc-sba.txt     | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/brcm,iproc-sba.txt

diff --git a/Documentation/devicetree/bindings/dma/brcm,iproc-sba.txt b/Documentation/devicetree/bindings/dma/brcm,iproc-sba.txt
new file mode 100644
index 0000000..092913a
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/brcm,iproc-sba.txt
@@ -0,0 +1,29 @@
+* Broadcom SBA RAID engine
+
+Required properties:
+- compatible: Should be one of the following
+	      "brcm,iproc-sba"
+	      "brcm,iproc-sba-v2"
+  The "brcm,iproc-sba" has support for only 6 PQ coefficients
+  The "brcm,iproc-sba-v2" has support for only 30 PQ coefficients
+- mboxes: List of phandle and mailbox channel specifiers
+
+Example:
+
+raid_mbox: mbox at 67400000 {
+	...
+	#mbox-cells = <3>;
+	...
+};
+
+raid0 {
+	compatible = "brcm,iproc-sba-v2";
+	mboxes = <&raid_mbox 0 0x1 0xffff>,
+		 <&raid_mbox 1 0x1 0xffff>,
+		 <&raid_mbox 2 0x1 0xffff>,
+		 <&raid_mbox 3 0x1 0xffff>,
+		 <&raid_mbox 4 0x1 0xffff>,
+		 <&raid_mbox 5 0x1 0xffff>,
+		 <&raid_mbox 6 0x1 0xffff>,
+		 <&raid_mbox 7 0x1 0xffff>;
+};
-- 
2.7.4
