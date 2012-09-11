From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 10:42:36 -0600
Subject: [PATCH V2] ARM: tegra: remove useless includes of <mach/*.h>
Message-ID: <1347381756-28714-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Nothing from these files is needed, so remove the includes. This helps
single zImage work by reducing use of the mach-tegra/include/mach/
directory.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Also remove 4 includes of <mach/suspend.h>
---
 arch/arm/mach-tegra/dma.c                 |    1 -
 arch/arm/mach-tegra/tegra20_clocks.c      |    1 -
 arch/arm/mach-tegra/tegra20_clocks_data.c |    1 -
 arch/arm/mach-tegra/timer.c               |    1 -
 arch/arm/mach-tegra/usb_phy.c             |    1 -
 5 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/dma.c b/arch/arm/mach-tegra/dma.c
index 29c5114..7f27320 100644
--- a/arch/arm/mach-tegra/dma.c
+++ b/arch/arm/mach-tegra/dma.c
@@ -31,7 +31,6 @@
 #include <mach/dma.h>
 #include <mach/irqs.h>
 #include <mach/iomap.h>
-#include <mach/suspend.h>
 
 #include "apbio.h"
 
diff --git a/arch/arm/mach-tegra/tegra20_clocks.c b/arch/arm/mach-tegra/tegra20_clocks.c
index e2a43e4..a4561da 100644
--- a/arch/arm/mach-tegra/tegra20_clocks.c
+++ b/arch/arm/mach-tegra/tegra20_clocks.c
@@ -28,7 +28,6 @@
 #include <linux/clk.h>
 
 #include <mach/iomap.h>
-#include <mach/suspend.h>
 
 #include "clock.h"
 #include "fuse.h"
diff --git a/arch/arm/mach-tegra/tegra20_clocks_data.c b/arch/arm/mach-tegra/tegra20_clocks_data.c
index be57764..0e8ed37 100644
--- a/arch/arm/mach-tegra/tegra20_clocks_data.c
+++ b/arch/arm/mach-tegra/tegra20_clocks_data.c
@@ -28,7 +28,6 @@
 #include <linux/clk.h>
 
 #include <mach/iomap.h>
-#include <mach/suspend.h>
 
 #include "clock.h"
 #include "fuse.h"
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 57b5bdc..eccdce9 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -33,7 +33,6 @@
 
 #include <mach/iomap.h>
 #include <mach/irqs.h>
-#include <mach/suspend.h>
 
 #include "board.h"
 #include "clock.h"
diff --git a/arch/arm/mach-tegra/usb_phy.c b/arch/arm/mach-tegra/usb_phy.c
index 022b33a..34ffebb 100644
--- a/arch/arm/mach-tegra/usb_phy.c
+++ b/arch/arm/mach-tegra/usb_phy.c
@@ -30,7 +30,6 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 #include <asm/mach-types.h>
-#include <mach/gpio-tegra.h>
 #include <mach/usb_phy.h>
 #include <mach/iomap.h>
 
-- 
1.7.0.4
