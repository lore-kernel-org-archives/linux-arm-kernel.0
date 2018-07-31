From: acolin@isi.edu (Alexei Colin)
Date: Tue, 31 Jul 2018 10:29:51 -0400
Subject: [RESEND PATCH 3/6] powerpc: factor out RapidIO Kconfig menu entry
In-Reply-To: <20180731142954.30345-1-acolin@isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
Message-ID: <20180731142954.30345-4-acolin@isi.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The menu entry is now defined in the rapidio subtree.  Also, re-order
the bus menu so tha the platform-specific RapidIO controller appears
after the entry for the RapidIO subsystem.

Platforms with a PCI bus will be offered the RapidIO menu since they may
be want support for a RapidIO PCI device. Platforms without a PCI bus
that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
in the platform-/machine-specific "config ARCH_*" Kconfig entry.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: x86 at kernel.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-mips at linux-mips.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 arch/powerpc/Kconfig | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 25d005af0a5b..17ea8a5f90a0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -993,16 +993,7 @@ source "drivers/pci/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
 
-config HAS_RAPIDIO
-	bool
-	default n
-
-config RAPIDIO
-	tristate "RapidIO support"
-	depends on HAS_RAPIDIO || PCI
-	help
-	  If you say Y here, the kernel will include drivers and
-	  infrastructure code to support RapidIO interconnect devices.
+source "drivers/rapidio/Kconfig"
 
 config FSL_RIO
 	bool "Freescale Embedded SRIO Controller support"
@@ -1012,8 +1003,6 @@ config FSL_RIO
 	  Include support for RapidIO controller on Freescale embedded
 	  processors (MPC8548, MPC8641, etc).
 
-source "drivers/rapidio/Kconfig"
-
 endmenu
 
 config NONSTATIC_KERNEL
-- 
2.18.0
