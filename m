From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Jan 2015 22:59:21 +0100
Subject: [PATCH] ARM: integrator: remove unused variable
Message-ID: <1666566.z9ZP4KJ7VA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch to add the new generic config space accessors removed
a useless spinlock, but left the flags variable in place, which
now causes a build warning:

arch/arm/mach-integrator/pci_v3.c: In function 'pci_v3_preinit':
arch/arm/mach-integrator/pci_v3.c:614:16: warning: unused variable 'flags' [-Wunused-variable]

This removes it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 1ba525109219 ("ARM: integrator: Convert PCI to use generic config accessors")

diff --git a/arch/arm/mach-integrator/pci_v3.c b/arch/arm/mach-integrator/pci_v3.c
index dc7782f26cbb..2565f0e7b5cf 100644
--- a/arch/arm/mach-integrator/pci_v3.c
+++ b/arch/arm/mach-integrator/pci_v3.c
@@ -611,7 +611,6 @@ static int __init pci_v3_setup(int nr, struct pci_sys_data *sys)
  */
 static void __init pci_v3_preinit(void)
 {
-	unsigned long flags;
 	unsigned int temp;
 	phys_addr_t io_address = pci_pio_to_address(io_mem.start);
 
