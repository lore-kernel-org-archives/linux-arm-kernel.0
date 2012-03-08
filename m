From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu,  8 Mar 2012 15:51:27 +0100
Subject: [PATCH 07/11] ARM: pci: Keep pci_common_init() around after init
In-Reply-To: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1331218291-16119-8-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 arch/arm/kernel/bios32.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index be5d3b2..c88dcf5 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -411,7 +411,7 @@ static int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-static void __init pcibios_init_hw(struct hw_pci *hw)
+static void pcibios_init_hw(struct hw_pci *hw)
 {
 	struct pci_sys_data *sys = NULL;
 	int ret;
@@ -457,7 +457,7 @@ static void __init pcibios_init_hw(struct hw_pci *hw)
 	}
 }
 
-void __init pci_common_init(struct hw_pci *hw)
+void pci_common_init(struct hw_pci *hw)
 {
 	struct pci_sys_data *sys;
 
-- 
1.7.9.3
