From: acolin@isi.edu (Alexei Colin)
Date: Tue, 31 Jul 2018 10:29:54 -0400
Subject: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
In-Reply-To: <20180731142954.30345-1-acolin@isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
Message-ID: <20180731142954.30345-7-acolin@isi.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platforms with a PCI bus will be offered the RapidIO menu since they may
be want support for a RapidIO PCI device. Platforms without a PCI bus
that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
in the platform-/machine-specific "config ARCH_*" Kconfig entry.

Tested that kernel builds for arm64 with RapidIO subsystem and
switch drivers enabled, also that the modules load successfully
on a custom Aarch64 Qemu model.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: John Paul Walters <jwalters@isi.edu>
Cc: x86 at kernel.org
Cc: linuxppc-dev at lists.ozlabs.org
Cc: linux-mips at linux-mips.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org,
Signed-off-by: Alexei Colin <acolin@isi.edu>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a8f0c74e6f7f..5e8cf90505ec 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -308,6 +308,8 @@ config PCI_SYSCALL
 
 source "drivers/pci/Kconfig"
 
+source "drivers/rapidio/Kconfig"
+
 endmenu
 
 menu "Kernel Features"
-- 
2.18.0
