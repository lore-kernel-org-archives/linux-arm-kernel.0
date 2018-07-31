From: acolin@isi.edu (Alexei Colin)
Date: Tue, 31 Jul 2018 10:29:52 -0400
Subject: [RESEND PATCH 4/6] mips: factor out RapidIO Kconfig entry
In-Reply-To: <20180731142954.30345-1-acolin@isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
Message-ID: <20180731142954.30345-5-acolin@isi.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The menu entry is now defined in the rapidio subtree.

Platforms with a PCI bus will be offered the RapidIO menu since they may
be want support for a RapidIO PCI device. Platforms without a PCI bus
that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
in the platform-/machine-specific "config ARCH_*" Kconfig entry.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: x86 at kernel.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-mips at linux-mips.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 arch/mips/Kconfig | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 10256056647c..92b9262ee731 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3106,17 +3106,6 @@ config ZONE_DMA32
 
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
-
 source "drivers/rapidio/Kconfig"
 
 endmenu
-- 
2.18.0
