From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 2 Oct 2015 23:26:45 +0530
Subject: [PATCH 4/5] Documentation: dt-bindings: Add info about brcm,
 nand-iproc-reset DT flag
In-Reply-To: <1443808606-21203-1-git-send-email-anup.patel@broadcom.com>
References: <1443808606-21203-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1443808606-21203-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the BRCM NAND controller DT bindings documentation
to add info about newly added optional flag "brcm,nand-iproc-reset".

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Pramod KUMAR <pramodku@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
index 4ff7128..19b7a3c 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
@@ -78,6 +78,10 @@ we define additional 'compatible' properties and associated register resources w
        for interrupt status/ack.
      - reg-names: (required) a list of the names corresponding to the previous
        register ranges. Should contain "iproc-idm" and "iproc-ext".
+     - brcm,nand-iproc-reset: (optional) Some of the Broadcom IPROC SoCs
+       require NAND controller to be resetted for cleanup of previously
+       configured NAND controller state. This optional flag resets the
+       NAND controller once before any NAND commands are issued.
 
 
 * NAND chip-select
-- 
1.9.1
