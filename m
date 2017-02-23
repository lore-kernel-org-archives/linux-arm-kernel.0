From: steven.lin1@broadcom.com (Steve Lin)
Date: Thu, 23 Feb 2017 09:49:52 -0500
Subject: [PATCH v2 3/3] dt-bindings: mailbox: Update doc with NSP PDC/mailbox
 support
In-Reply-To: <1487861392-23039-1-git-send-email-steven.lin1@broadcom.com>
References: <1487861392-23039-1-git-send-email-steven.lin1@broadcom.com>
Message-ID: <1487861392-23039-4-git-send-email-steven.lin1@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the DT bindings documentation to reflect the new NSP version
of PDC driver compatibility string.

Signed-off-by: Steve Lin <steven.lin1@broadcom.com>
---
 Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
index 411ccf4..0f3ee81 100644
--- a/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
@@ -1,9 +1,11 @@
 The PDC driver manages data transfer to and from various offload engines
 on some Broadcom SoCs. An SoC may have multiple PDC hardware blocks. There is
-one device tree entry per block.
+one device tree entry per block.  On some chips, the PDC functionality is
+handled by the FA2 (Northstar Plus).
 
 Required properties:
-- compatible : Should be "brcm,iproc-pdc-mbox".
+- compatible : Should be "brcm,iproc-pdc-mbox" or "brcm,iproc-fa2-mbox" for
+  FA2/Northstar Plus.
 - reg: Should contain PDC registers location and length.
 - interrupts: Should contain the IRQ line for the PDC.
 - #mbox-cells: 1
-- 
2.1.0
