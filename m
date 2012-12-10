From: ciminaghi@gnudd.com (Davide Ciminaghi)
Date: Mon, 10 Dec 2012 14:42:31 +0100
Subject: [PATCH v4 2/7] pl080.h: moved from arm/include/asm/hardware to
 include/linux/amba/
In-Reply-To: <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
References: <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
Message-ID: <1355146956-6009-3-git-send-email-ciminaghi@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@gnudd.com>

The header is used by drivers/dma/amba-pl08x.c, which can be compiled
under x86, where PL080 exists under a PCI-to-AMBA bridge. This patche
moves it where it can be accessed by other architectures, and fixes
all users.

Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
---
 arch/arm/mach-s3c64xx/dma.c                                   |    2 +-
 arch/arm/mach-spear3xx/spear3xx.c                             |    2 +-
 arch/arm/mach-spear6xx/spear6xx.c                             |    2 +-
 drivers/dma/amba-pl08x.c                                      |    2 +-
 {arch/arm/include/asm/hardware => include/linux/amba}/pl080.h |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename {arch/arm/include/asm/hardware => include/linux/amba}/pl080.h (99%)

diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index f2a7a17..a77f521 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/amba/pl080.h>
 
 #include <mach/dma.h>
 #include <mach/map.h>
@@ -30,7 +31,6 @@
 
 #include <mach/regs-sys.h>
 
-#include <asm/hardware/pl080.h>
 
 /* dma channel state information */
 
diff --git a/arch/arm/mach-spear3xx/spear3xx.c b/arch/arm/mach-spear3xx/spear3xx.c
index 38fe95d..88be9a3 100644
--- a/arch/arm/mach-spear3xx/spear3xx.c
+++ b/arch/arm/mach-spear3xx/spear3xx.c
@@ -16,9 +16,9 @@
 #include <linux/amba/pl022.h>
 #include <linux/amba/pl08x.h>
 #include <linux/irqchip/spear-shirq.h>
+#include <linux/amba/pl080.h>
 #include <linux/of_irq.h>
 #include <linux/io.h>
-#include <asm/hardware/pl080.h>
 #include <asm/hardware/vic.h>
 #include <plat/pl080.h>
 #include <mach/generic.h>
diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
index 5a5a52d..8ce65a2 100644
--- a/arch/arm/mach-spear6xx/spear6xx.c
+++ b/arch/arm/mach-spear6xx/spear6xx.c
@@ -20,7 +20,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <asm/hardware/pl080.h>
+#include <linux/amba/pl080.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 6eb6a5c..8bad254 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -83,7 +83,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-#include <asm/hardware/pl080.h>
+#include <linux/amba/pl080.h>
 
 #include "dmaengine.h"
 #include "virt-dma.h"
diff --git a/arch/arm/include/asm/hardware/pl080.h b/include/linux/amba/pl080.h
similarity index 99%
rename from arch/arm/include/asm/hardware/pl080.h
rename to include/linux/amba/pl080.h
index 4eea210..3e7b62f 100644
--- a/arch/arm/include/asm/hardware/pl080.h
+++ b/include/linux/amba/pl080.h
@@ -1,4 +1,4 @@
-/* arch/arm/include/asm/hardware/pl080.h
+/* include/linux/amba/pl080.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
-- 
1.7.10.4
