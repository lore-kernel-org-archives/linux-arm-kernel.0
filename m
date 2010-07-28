From: PeterHuewe@gmx.de (Peter Huewe)
Date: Wed, 28 Jul 2010 20:43:13 +0200
Subject: [PATCH] arm/mach-ixp2000: Add missing comma - fix build failure
Message-ID: <201007282043.13561.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Huewe <peterhuewe@gmx.de>

This trivial patch fixes a build failure [1] by adding a missing comma.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
KernelVersion: linux-next-20100728

References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2980895/

BF introduced by 3cad685d - ARM: 6253/1: Add 'code' parameter for
hook_fault_code()

 arch/arm/mach-ixp2000/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ixp2000/pci.c b/arch/arm/mach-ixp2000/pci.c
index 853fd90..f797c5f 100644
--- a/arch/arm/mach-ixp2000/pci.c
+++ b/arch/arm/mach-ixp2000/pci.c
@@ -209,7 +209,7 @@ ixp2000_pci_preinit(void)
 			"the needed workaround has not been configured in");
 #endif
 
-	hook_fault_code(16+6, ixp2000_pci_abort_handler, SIGBUS, 0
+	hook_fault_code(16+6, ixp2000_pci_abort_handler, SIGBUS, 0,
 				"PCI config cycle to non-existent device");
 }
 
-- 
1.7.1
