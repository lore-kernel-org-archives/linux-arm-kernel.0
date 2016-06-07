From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 18:54:54 +0100
Subject: [PATCH] soc: brcmstb: fix warning from missing include
Message-ID: <1465322094-25692-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The brcmstb_biuctrl_init() is defined in the soc specific header
file, but wasn't included in the driver file. Fix the following
warning by including <linux/soc/brcmstb/brcmstb.h> in the driver:

drivers/soc/brcmstb/biuctrl.c:101:13: warning: symbol 'brcmstb_biuctrl_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Gregory Fong <gregory.0xf0@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: bcm-kernel-feedback-list at broadcom.com
---
 drivers/soc/brcmstb/biuctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/brcmstb/biuctrl.c b/drivers/soc/brcmstb/biuctrl.c
index 9049c076f..3c39415 100644
--- a/drivers/soc/brcmstb/biuctrl.c
+++ b/drivers/soc/brcmstb/biuctrl.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
+#include <linux/soc/brcmstb/brcmstb.h>
 
 #define CPU_CREDIT_REG_OFFSET			0x184
 #define  CPU_CREDIT_REG_MCPx_WR_PAIRING_EN_MASK	0x70000000
-- 
2.8.1
