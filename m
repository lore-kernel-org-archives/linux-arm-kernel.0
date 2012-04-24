From: tartler@cs.fau.de (Reinhard Tartler)
Date: Tue, 24 Apr 2012 14:36:16 +0200
Subject: [PATCH] ARM: mach-iop13xx: fix parameter declaration of
 iq81340sc_atux_map_irq
Message-ID: <1335270976-5553-1-git-send-email-tartler@cs.fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Reinhard Tartler <siretart@tauware.de>

Fixes the following compiler warning:
arch/arm/mach-iop13xx/iq81340sc.c:63: warning: initialization from incompatible pointer type | warning: (near initialization for ?iq81340sc_pci.map_irq?)

Signed-off-by: Reinhard Tartler <tartler@cs.fau.de>
---
 arch/arm/mach-iop13xx/iq81340sc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-iop13xx/iq81340sc.c b/arch/arm/mach-iop13xx/iq81340sc.c
index cd9e274..70e8db0 100644
--- a/arch/arm/mach-iop13xx/iq81340sc.c
+++ b/arch/arm/mach-iop13xx/iq81340sc.c
@@ -30,7 +30,7 @@
 extern int init_atu;
 
 static int __init
-iq81340sc_atux_map_irq(struct pci_dev *dev, u8 idsel, u8 pin)
+iq81340sc_atux_map_irq(const struct pci_dev *dev, u8 idsel, u8 pin)
 {
 	WARN_ON(idsel < 1 || idsel > 2);
 
-- 
1.7.9.5
