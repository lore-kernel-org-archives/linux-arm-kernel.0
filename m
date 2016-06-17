From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 17 Jun 2016 16:05:13 +0100
Subject: [PATCH 9/9] [RFC] pci: include <asm/dma.h> for isa_dma_bridge_buggy
In-Reply-To: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466175913-19067-10-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least on arm, <asm/dma.h> does not get included when building
drivers/pci/pci.o. This causes the following build warning which
can be fixed by including <asm/dma.h>:

drivers/pci/pci.c:37:5: warning: symbol 'isa_dma_bridge_buggy' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9add285..86b538d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pci_hotplug.h>
 #include <asm/setup.h>
+#include <asm/dma.h>
 #include <linux/aer.h>
 #include "pci.h"
 
-- 
2.8.1
