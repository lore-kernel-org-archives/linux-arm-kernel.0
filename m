From: acolin@isi.edu (Alexei Colin)
Date: Tue, 31 Jul 2018 10:29:53 -0400
Subject: [RESEND PATCH 5/6] arm: enable RapidIO menu in Kconfig
In-Reply-To: <20180731142954.30345-1-acolin@isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
Message-ID: <20180731142954.30345-6-acolin@isi.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platforms with a PCI bus will be offered the RapidIO menu since they may
be want support for a RapidIO PCI device. Platforms without a PCI bus
that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
in the platform-/machine-specific "config ARCH_*" Kconfig entry.

Tested that kernel builds for ARM with the RapidIO subsystem and switch
drivers enabled.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: linux-kernel at vger.kernel.org
Cc: x86 at kernel.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-mips at linux-mips.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 arch/arm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index afe350e5e3d9..602a61324890 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1278,6 +1278,8 @@ config PCI_HOST_ITE8152
 
 source "drivers/pci/Kconfig"
 
+source "drivers/rapidio/Kconfig"
+
 source "drivers/pcmcia/Kconfig"
 
 endmenu
-- 
2.18.0
