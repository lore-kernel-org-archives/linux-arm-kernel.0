From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 21 Feb 2011 11:08:23 -0700 (MST)
Subject: [PATCH 1/3] OMAP: smartreflex: move plat/smartreflex.h to
	mach-omap2/smartreflex.h
In-Reply-To: <4D6236AE.7000407@ti.com>
References: <20110221020231.7598.14024.stgit@twilight.localdomain>
	<20110221020851.7598.57763.stgit@twilight.localdomain>
	<4D6236AE.7000407@ti.com>
Message-ID: <alpine.DEB.2.00.1102211107530.22636@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno?t,

On Mon, 21 Feb 2011, Cousson, Benoit wrote:

> In fact that include is not used for OMAP4 data and does not seems to be used
> either in this file.
> I guess you can simply remove it.

Thanks, done.  Updated patch below.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Wed, 16 Feb 2011 21:49:21 -0700
Subject: [PATCH] OMAP: smartreflex: move plat/smartreflex.h to mach-omap2/smartreflex.h
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There's no reason for this header file to be in
plat-omap/include/plat/smartreflex.h.  The hardware devices are in
OMAP2+ SoCs only.  Leaving this header file in plat-omap causes
problems due to cross-dependencies with other header files that should
live in mach-omap2/.

Thanks to Beno?t Cousson <b-cousson@ti.com> for suggesting the removal
of the smartreflex.h include from the OMAP3xxx hwmod data.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    1 -
 arch/arm/mach-omap2/smartreflex-class3.c           |    2 +-
 arch/arm/mach-omap2/smartreflex.c                  |    2 +-
 .../include/plat => mach-omap2}/smartreflex.h      |    0
 arch/arm/mach-omap2/sr_device.c                    |    2 +-
 5 files changed, 3 insertions(+), 4 deletions(-)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/smartreflex.h (100%)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8d81813..5445588 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -21,7 +21,6 @@
 #include <plat/l4_3xxx.h>
 #include <plat/i2c.h>
 #include <plat/gpio.h>
-#include <plat/smartreflex.h>
 
 #include "omap_hwmod_common_data.h"
 
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 60e7055..f438cf4 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -11,7 +11,7 @@
  * published by the Free Software Foundation.
  */
 
-#include <plat/smartreflex.h>
+#include "smartreflex.h"
 
 static int sr_class3_enable(struct voltagedomain *voltdm)
 {
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index c37e823..077dfb6 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -26,9 +26,9 @@
 #include <linux/pm_runtime.h>
 
 #include <plat/common.h>
-#include <plat/smartreflex.h>
 
 #include "pm.h"
+#include "smartreflex.h"
 
 #define SMARTREFLEX_NAME_LEN	16
 #define NVALUE_NAME_LEN		40
diff --git a/arch/arm/plat-omap/include/plat/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/smartreflex.h
rename to arch/arm/mach-omap2/smartreflex.h
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index b1e0af1..a636604 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -23,9 +23,9 @@
 #include <linux/io.h>
 
 #include <plat/omap_device.h>
-#include <plat/smartreflex.h>
 #include <plat/voltage.h>
 
+#include "smartreflex.h"
 #include "control.h"
 #include "pm.h"
 
-- 
1.7.2.3
