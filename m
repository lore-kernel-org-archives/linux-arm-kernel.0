From: hare@suse.de (Hannes Reinecke)
Date: Tue, 12 Jun 2012 15:59:45 +0200
Subject: [PATCH] mach-dove: Fixup ge00 initialisation
Message-ID: <1339509585-62405-1-git-send-email-hare@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The last argument of orion_ge00_init() is actually the error
interrupt, so we should be using the correct value here.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 arch/arm/mach-dove/common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index f7d639b..a9d0708 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -101,8 +101,8 @@ void __init dove_ehci1_init(void)
  ****************************************************************************/
 void __init dove_ge00_init(struct mv643xx_eth_platform_data *eth_data)
 {
-	orion_ge00_init(eth_data,
-			DOVE_GE00_PHYS_BASE, IRQ_DOVE_GE00_SUM, 0);
+	orion_ge00_init(eth_data, DOVE_GE00_PHYS_BASE,
+			IRQ_DOVE_GE00_SUM, IRQ_DOVE_GE00_ERR);
 }
 
 /*****************************************************************************
-- 
1.7.4.2
