From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 02 Feb 2016 13:38:49 -0600
Subject: [PATCH 3/5] ARM64: PCI: Remove generated include of
 asm-generic/pci-bridge.h
In-Reply-To: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20160202193849.9258.63617.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64 generates asm/pci-bridge.h, which merely includes the now-empty
asm-generic/pci-bridge.h.  Stop generating asm/pci-bridge.h, and stop
including it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm64/include/asm/Kbuild |    3 ---
 arch/arm64/kernel/pci.c       |    2 --
 2 files changed, 5 deletions(-)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 70fd9ff..cff532a 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -1,5 +1,3 @@
-
-
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += checksum.h
@@ -31,7 +29,6 @@ generic-y += msgbuf.h
 generic-y += msi.h
 generic-y += mutex.h
 generic-y += pci.h
-generic-y += pci-bridge.h
 generic-y += poll.h
 generic-y += preempt.h
 generic-y += resource.h
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index b3d098b..c72de66 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -19,8 +19,6 @@
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 
-#include <asm/pci-bridge.h>
-
 /*
  * Called after each bus is probed, but before its children are examined
  */
