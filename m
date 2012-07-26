From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 26 Jul 2012 21:55:04 +0200
Subject: [PATCH v3 02/10] ARM: pci: Keep pci_common_init() around after init
In-Reply-To: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1343332512-28762-3-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using deferred driver probing, PCI host controller drivers may
actually require this function after the init stage.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v3:
- none

Changes in v2:
- use __devinit annotations

 arch/arm/kernel/bios32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 70dabb9..5c3dd59 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -456,7 +456,7 @@ static int __init pcibios_init_resources(int busnr, struct pci_sys_data *sys)
 	return 0;
 }
 
-static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
+static void __devinit pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 {
 	struct pci_sys_data *sys = NULL;
 	int ret;
@@ -504,7 +504,7 @@ static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 	}
 }
 
-void __init pci_common_init(struct hw_pci *hw)
+void __devinit pci_common_init(struct hw_pci *hw)
 {
 	struct pci_sys_data *sys;
 	LIST_HEAD(head);
-- 
1.7.11.2
