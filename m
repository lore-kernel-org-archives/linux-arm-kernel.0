From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 12 May 2012 11:05:46 +0200
Subject: [PATCH] ARM: integrator: fix typo in PCI swizzle function
Message-ID: <1336813546-25766-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The next tree didn't compile due to a typo in commit
cfb32a689949d09f112493de4a1e3e5900db2053
"ARM: PCI: integrator: use common PCI swizzle"

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-integrator/pci.c b/arch/arm/mach-integrator/pci.c
index 40f4b4f..6c1667e 100644
--- a/arch/arm/mach-integrator/pci.c
+++ b/arch/arm/mach-integrator/pci.c
@@ -73,7 +73,7 @@ static u8 __init integrator_swizzle(struct pci_dev *dev, u8 *pinp)
 	if (*pinp == 0)
 		*pinp = 1;
 
-	return pci_std_swizzle(dev, pinp);
+	return pci_common_swizzle(dev, pinp);
 }
 
 static int irq_tab[4] __initdata = {
-- 
1.7.7.6
