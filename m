From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Mon, 22 May 2017 15:09:35 +0300
Subject: [PATCH 5/5][v5] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20170522120935.4119-1-laurentiu.tudor@nxp.com>
References: <20170522120935.4119-1-laurentiu.tudor@nxp.com>
Message-ID: <20170522120935.4119-6-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stuart Yoder <stuart.yoder@nxp.com>

Move the source files out of staging into their final locations:
  -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
  -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
  -source in drivers/staging/fsl-mc/bus goes to drivers/bus/fsl-mc
  -README.txt, providing and overview of DPAA goes to
   Documentation/dpaa2/overview.txt

Update or delete other remaining staging files-- Makefile, Kconfig, TODO.
Update dpaa2_eth and dpio staging drivers.

Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
[Laurentiu: rebased, add dpaa2_eth and dpio #include updates]
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---

Notes:
    -v5
      -no changes
    -v4
      -rebased
      -update existing dpaa2 drivers to work with the bus out of staging
    -v3
      -no changes
    -v2
      -updated MAINTAINERS with new location

 .../README.txt => Documentation/dpaa2/overview.txt    |  0
 MAINTAINERS                                           |  2 +-
 drivers/bus/Kconfig                                   |  2 ++
 drivers/bus/Makefile                                  |  3 +++
 drivers/bus/fsl-mc/Kconfig                            | 17 +++++++++++++++++
 drivers/bus/fsl-mc/Makefile                           | 19 +++++++++++++++++++
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp-cmd.h |  0
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c     |  6 +++---
 .../{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp-cmd.h    |  0
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c    |  4 ++--
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.h    |  0
 .../{staging/fsl-mc/bus => bus/fsl-mc}/dpmng-cmd.h    |  0
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmng.c    |  6 +++---
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-cmd.h |  0
 .../{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c  |  4 ++--
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c     |  6 +++---
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c      |  6 +++---
 .../{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c   |  6 +++---
 .../{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c   |  5 +++--
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h        |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c    |  5 +++--
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c   |  6 +++---
 drivers/irqchip/Makefile                              |  1 +
 .../bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c       |  3 +--
 drivers/staging/fsl-dpaa2/ethernet/README             |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c        |  4 ++--
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h        |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni.c             |  4 ++--
 drivers/staging/fsl-mc/TODO                           | 18 ------------------
 drivers/staging/fsl-mc/bus/Kconfig                    | 10 ----------
 drivers/staging/fsl-mc/bus/Makefile                   | 15 +--------------
 drivers/staging/fsl-mc/bus/dpcon.c                    |  8 ++++----
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c         |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c        |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.c                |  4 ++--
 .../fsl-mc/include => include/linux/fsl}/dpbp.h       |  0
 .../fsl-mc/bus => include/linux/fsl}/dpcon-cmd.h      |  0
 .../fsl-mc/include => include/linux/fsl}/dpmng.h      |  0
 .../fsl-mc/include => include/linux/fsl}/dprc.h       |  1 -
 .../fsl-mc/include => include/linux/fsl}/mc-bus.h     |  2 +-
 .../fsl-mc/include => include/linux/fsl}/mc-cmd.h     |  0
 .../fsl-mc/include => include/linux/fsl}/mc-sys.h     |  0
 .../staging/fsl-mc/include => include/linux/fsl}/mc.h |  2 +-
 43 files changed, 90 insertions(+), 89 deletions(-)
 rename drivers/staging/fsl-mc/README.txt => Documentation/dpaa2/overview.txt (100%)
 create mode 100644 drivers/bus/fsl-mc/Kconfig
 create mode 100644 drivers/bus/fsl-mc/Makefile
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.h (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmng-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmng.c (96%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c (99%)
 rename drivers/{staging/fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c (98%)
 delete mode 100644 drivers/staging/fsl-mc/TODO
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/dpbp.h (100%)
 rename {drivers/staging/fsl-mc/bus => include/linux/fsl}/dpcon-cmd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/dpmng.h (100%)
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/dprc.h (99%)
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc-bus.h (99%)
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc-cmd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc-sys.h (100%)
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc.h (99%)

diff --git a/drivers/staging/fsl-mc/README.txt b/Documentation/dpaa2/overview.txt
similarity index 100%
rename from drivers/staging/fsl-mc/README.txt
rename to Documentation/dpaa2/overview.txt
diff --git a/MAINTAINERS b/MAINTAINERS
index ffac090..4bc71be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10544,7 +10544,7 @@ M:	Stuart Yoder <stuyoder@gmail.com>
 M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
 L:	linux-kernel at vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-mc/
+F:	drivers/bus/fsl-mc/
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
 
 QT1010 MEDIA DRIVER
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 0a52da4..dbb1f44 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -184,4 +184,6 @@ config DA8XX_MSTPRI
 	  configuration. Allows to adjust the priorities of all master
 	  peripherals.
 
+source "drivers/bus/fsl-mc/Kconfig"
+
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index cc6364b..dee9a84 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -14,6 +14,9 @@ obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
 # Interconnect bus driver for OMAP SoCs.
 obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
 
+# DPAA2 fsl-mc bus
+obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
+
 obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
 obj-$(CONFIG_QCOM_EBI2)		+= qcom-ebi2.o
 obj-$(CONFIG_SUNXI_RSB)		+= sunxi-rsb.o
diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
new file mode 100644
index 0000000..5c009ab
--- /dev/null
+++ b/drivers/bus/fsl-mc/Kconfig
@@ -0,0 +1,17 @@
+#
+# DPAA2 fsl-mc bus
+#
+# Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
+#
+# This file is released under the GPLv2
+#
+
+config FSL_MC_BUS
+	bool "QorIQ DPAA2 fsl-mc bus driver"
+	depends on OF && ARCH_LAYERSCAPE
+	select GENERIC_MSI_IRQ_DOMAIN
+	help
+	  Driver to enable the bus infrastructure for the QorIQ DPAA2
+	  architecture.  The fsl-mc bus driver handles discovery of
+	  DPAA2 objects (which are represented as Linux devices) and
+	  binding objects to drivers.
diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
new file mode 100644
index 0000000..d56afee
--- /dev/null
+++ b/drivers/bus/fsl-mc/Makefile
@@ -0,0 +1,19 @@
+#
+# Freescale Management Complex (MC) bus drivers
+#
+# Copyright (C) 2014 Freescale Semiconductor, Inc.
+#
+# This file is released under the GPLv2
+#
+obj-$(CONFIG_FSL_MC_BUS) += mc-bus-driver.o
+
+mc-bus-driver-objs := fsl-mc-bus.o \
+		      mc-sys.o \
+		      mc-io.o \
+		      dprc.o \
+		      dpmng.o \
+		      dprc-driver.o \
+		      fsl-mc-allocator.o \
+		      fsl-mc-msi.o \
+		      dpmcp.o \
+		      dpbp.o
diff --git a/drivers/staging/fsl-mc/bus/dpbp-cmd.h b/drivers/bus/fsl-mc/dpbp-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpbp-cmd.h
rename to drivers/bus/fsl-mc/dpbp-cmd.h
diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
similarity index 98%
rename from drivers/staging/fsl-mc/bus/dpbp.c
rename to drivers/bus/fsl-mc/dpbp.c
index d9e450a..3a7bc3d 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/bus/fsl-mc/dpbp.c
@@ -29,9 +29,9 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
-#include "../include/mc-sys.h"
-#include "../include/mc-cmd.h"
-#include "../include/dpbp.h"
+#include <linux/fsl/mc-sys.h>
+#include <linux/fsl/mc-cmd.h>
+#include <linux/fsl/dpbp.h>
 
 #include "dpbp-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dpmcp-cmd.h b/drivers/bus/fsl-mc/dpmcp-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpmcp-cmd.h
rename to drivers/bus/fsl-mc/dpmcp-cmd.h
diff --git a/drivers/staging/fsl-mc/bus/dpmcp.c b/drivers/bus/fsl-mc/dpmcp.c
similarity index 98%
rename from drivers/staging/fsl-mc/bus/dpmcp.c
rename to drivers/bus/fsl-mc/dpmcp.c
index ad4c8b4..5c5c2aa 100644
--- a/drivers/staging/fsl-mc/bus/dpmcp.c
+++ b/drivers/bus/fsl-mc/dpmcp.c
@@ -29,8 +29,8 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
-#include "../include/mc-sys.h"
-#include "../include/mc-cmd.h"
+#include <linux/fsl/mc-sys.h>
+#include <linux/fsl/mc-cmd.h>
 
 #include "dpmcp.h"
 #include "dpmcp-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/dpmcp.h b/drivers/bus/fsl-mc/dpmcp.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpmcp.h
rename to drivers/bus/fsl-mc/dpmcp.h
diff --git a/drivers/staging/fsl-mc/bus/dpmng-cmd.h b/drivers/bus/fsl-mc/dpmng-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpmng-cmd.h
rename to drivers/bus/fsl-mc/dpmng-cmd.h
diff --git a/drivers/staging/fsl-mc/bus/dpmng.c b/drivers/bus/fsl-mc/dpmng.c
similarity index 96%
rename from drivers/staging/fsl-mc/bus/dpmng.c
rename to drivers/bus/fsl-mc/dpmng.c
index ad5d5bb..312fa0ee 100644
--- a/drivers/staging/fsl-mc/bus/dpmng.c
+++ b/drivers/bus/fsl-mc/dpmng.c
@@ -29,9 +29,9 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
-#include "../include/mc-sys.h"
-#include "../include/mc-cmd.h"
-#include "../include/dpmng.h"
+#include <linux/fsl/mc-sys.h>
+#include <linux/fsl/mc-cmd.h>
+#include <linux/fsl/dpmng.h>
 
 #include "dpmng-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dprc-cmd.h b/drivers/bus/fsl-mc/dprc-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dprc-cmd.h
rename to drivers/bus/fsl-mc/dprc-cmd.h
diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dprc-driver.c
rename to drivers/bus/fsl-mc/dprc-driver.c
index 39c9a3b..2a392fd 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -13,8 +13,8 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/msi.h>
-#include "../include/mc-bus.h"
-#include "../include/mc-sys.h"
+#include <linux/fsl/mc-bus.h>
+#include <linux/fsl/mc-sys.h>
 
 #include "dprc-cmd.h"
 #include "fsl-mc-private.h"
diff --git a/drivers/staging/fsl-mc/bus/dprc.c b/drivers/bus/fsl-mc/dprc.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dprc.c
rename to drivers/bus/fsl-mc/dprc.c
index fcf7b47..069e4dd 100644
--- a/drivers/staging/fsl-mc/bus/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -29,9 +29,9 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
-#include "../include/mc-sys.h"
-#include "../include/mc-cmd.h"
-#include "../include/dprc.h"
+#include <linux/fsl/mc-sys.h>
+#include <linux/fsl/mc-cmd.h>
+#include <linux/fsl/dprc.h>
 
 #include "dprc-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
rename to drivers/bus/fsl-mc/fsl-mc-allocator.c
index d3def40..5ea3b26 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -10,11 +10,11 @@
 
 #include <linux/module.h>
 #include <linux/msi.h>
-#include "../include/mc-bus.h"
-#include "../include/mc-sys.h"
+#include <linux/fsl/mc-bus.h>
+#include <linux/fsl/mc-sys.h>
+#include <linux/fsl/dpcon-cmd.h>
 
 #include "dpbp-cmd.h"
-#include "dpcon-cmd.h"
 #include "fsl-mc-private.h"
 
 #define FSL_MC_IS_ALLOCATABLE(_obj_type)	\
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/fsl-mc-bus.c
rename to drivers/bus/fsl-mc/fsl-mc-bus.c
index 7b48ade..f59aa9f 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -20,9 +20,9 @@
 #include <linux/bitops.h>
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
-#include "../include/mc-bus.h"
-#include "../include/dpmng.h"
-#include "../include/mc-sys.h"
+#include <linux/fsl/mc-bus.h>
+#include <linux/fsl/dpmng.h>
+#include <linux/fsl/mc-sys.h>
 
 #include "fsl-mc-private.h"
 #include "dprc-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/fsl-mc-msi.c
rename to drivers/bus/fsl-mc/fsl-mc-msi.c
index a92fa5a..42314b3 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -16,8 +16,9 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
-#include "../include/mc-bus.h"
-#include "../include/mc-cmd.h"
+#include <linux/fsl/mc-bus.h>
+#include <linux/fsl/mc-cmd.h>
+
 #include "fsl-mc-private.h"
 
 /*
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
similarity index 98%
rename from drivers/staging/fsl-mc/bus/fsl-mc-private.h
rename to drivers/bus/fsl-mc/fsl-mc-private.h
index 01ef9329..8912d19 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -10,7 +10,7 @@
 #ifndef _FSL_MC_PRIVATE_H_
 #define _FSL_MC_PRIVATE_H_
 
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 int __must_check fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 				   struct fsl_mc_io *mc_io,
diff --git a/drivers/staging/fsl-mc/bus/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/mc-io.c
rename to drivers/bus/fsl-mc/mc-io.c
index d66b87f..a24c11d 100644
--- a/drivers/staging/fsl-mc/bus/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -31,8 +31,9 @@
  */
 
 #include <linux/io.h>
-#include "../include/mc-bus.h"
-#include "../include/mc-sys.h"
+#include <linux/fsl/mc-bus.h>
+#include <linux/fsl/mc-sys.h>
+#include <linux/fsl/mc-cmd.h>
 
 #include "fsl-mc-private.h"
 #include "dpmcp.h"
diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/mc-sys.c
rename to drivers/bus/fsl-mc/mc-sys.c
index 4d82802..ac86226 100644
--- a/drivers/staging/fsl-mc/bus/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -37,9 +37,9 @@
 #include <linux/ioport.h>
 #include <linux/device.h>
 #include <linux/io.h>
-#include "../include/mc-sys.h"
-#include "../include/mc-cmd.h"
-#include "../include/mc.h"
+#include <linux/fsl/mc-sys.h>
+#include <linux/fsl/mc-cmd.h>
+#include <linux/fsl/mc.h>
 
 #include "dpmcp.h"
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index b64c59b..6cc4c26 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -76,3 +76,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
+obj-$(CONFIG_FSL_MC_BUS)		+= irq-gic-v3-its-fsl-mc-msi.o
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
similarity index 98%
rename from drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
rename to drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 49127ac..63cdd63 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -16,8 +16,7 @@
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include "../include/mc-bus.h"
-#include "fsl-mc-private.h"
+#include <linux/fsl/mc-bus.h>
 
 static struct irq_chip its_msi_irq_chip = {
 	.name = "ITS-fMSI",
diff --git a/drivers/staging/fsl-dpaa2/ethernet/README b/drivers/staging/fsl-dpaa2/ethernet/README
index 410952e..1e825df 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/README
+++ b/drivers/staging/fsl-dpaa2/ethernet/README
@@ -36,7 +36,7 @@ are treated as internal resources of other objects.
 
 For a more detailed description of the DPAA2 architecture and its object
 abstractions see:
-	drivers/staging/fsl-mc/README.txt
+	Documentation/dpaa2/overview.txt
 
 Each Linux net device is built on top of a Datapath Network Interface (DPNI)
 object and uses Buffer Pools (DPBPs), I/O Portals (DPIOs) and Concentrators
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 6f9eed6..97a64d2 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -38,8 +38,8 @@
 #include <linux/msi.h>
 #include <linux/kthread.h>
 
-#include "../../fsl-mc/include/mc.h"
-#include "../../fsl-mc/include/mc-sys.h"
+#include <linux/fsl/mc.h>
+#include <linux/fsl/mc-sys.h>
 #include "dpaa2-eth.h"
 
 /* CREATE_TRACE_POINTS only needs to be defined once. Other dpa files
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index c67cced..0a07b41 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -38,7 +38,7 @@
 
 #include "../../fsl-mc/include/dpaa2-io.h"
 #include "../../fsl-mc/include/dpaa2-fd.h"
-#include "../../fsl-mc/include/dpbp.h"
+#include <linux/fsl/dpbp.h>
 #include "../../fsl-mc/include/dpcon.h"
 #include "dpni.h"
 #include "dpni-cmd.h"
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpni.c b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
index cea46ed..4f758a9 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpni.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
@@ -30,8 +30,8 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
-#include "../../fsl-mc/include/mc-sys.h"
-#include "../../fsl-mc/include/mc-cmd.h"
+#include <linux/fsl/mc-sys.h>
+#include <linux/fsl/mc-cmd.h>
 #include "dpni.h"
 #include "dpni-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/TODO b/drivers/staging/fsl-mc/TODO
deleted file mode 100644
index 54a8bc6..0000000
--- a/drivers/staging/fsl-mc/TODO
+++ /dev/null
@@ -1,18 +0,0 @@
-* Add at least one device driver for a DPAA2 object (child device of the
-  fsl-mc bus).  Most likely candidate for this is adding DPAA2 Ethernet
-  driver support, which depends on drivers for several objects: DPNI,
-  DPIO, DPMAC.  Other pre-requisites include:
-
-     * MC firmware uprev.  The MC firmware upon which the fsl-mc
-       bus driver and DPAA2 object drivers are based is continuing
-       to evolve, so minor updates are needed to keep in sync with binary
-       interface changes to the MC.
-
-* Cleanup
-
-Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
-german.rivera at freescale.com, devel at driverdev.osuosl.org,
-linux-kernel at vger.kernel.org
-
-[1] https://lkml.org/lkml/2015/7/9/93
-[2] https://lkml.org/lkml/2015/7/7/712
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index a10aaf0..0f75b56 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -6,16 +6,6 @@
 # This file is released under the GPLv2
 #
 
-config FSL_MC_BUS
-	bool "QorIQ DPAA2 fsl-mc bus driver"
-	depends on OF && ARCH_LAYERSCAPE
-	select GENERIC_MSI_IRQ_DOMAIN
-	help
-	  Driver to enable the bus infrastructure for the QorIQ DPAA2
-	  architecture.  The fsl-mc bus driver handles discovery of
-	  DPAA2 objects (which are represented as Linux devices) and
-	  binding objects to drivers.
-
 config FSL_MC_DPIO
         tristate "QorIQ DPAA2 DPIO driver"
         depends on FSL_MC_BUS
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index 659eccf..e86ad44 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -5,20 +5,7 @@
 #
 # This file is released under the GPLv2
 #
-obj-$(CONFIG_FSL_MC_BUS) += mc-bus-driver.o
-
-mc-bus-driver-objs := fsl-mc-bus.o \
-		      mc-sys.o \
-		      mc-io.o \
-		      dprc.o \
-		      dpmng.o \
-		      dprc-driver.o \
-		      fsl-mc-allocator.o \
-		      fsl-mc-msi.o \
-		      irq-gic-v3-its-fsl-mc-msi.o \
-		      dpmcp.o \
-		      dpbp.o \
-		      dpcon.o
+obj-$(CONFIG_FSL_MC_BUS) += dpcon.o
 
 # MC DPIO driver
 obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpcon.c b/drivers/staging/fsl-mc/bus/dpcon.c
index eb71357..abbc3c2 100644
--- a/drivers/staging/fsl-mc/bus/dpcon.c
+++ b/drivers/staging/fsl-mc/bus/dpcon.c
@@ -29,11 +29,11 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
-#include "../include/mc-sys.h"
-#include "../include/mc-cmd.h"
-#include "../include/dpcon.h"
+#include <linux/fsl/mc-sys.h>
+#include <linux/fsl/mc-cmd.h>
+#include <linux/fsl/dpcon-cmd.h>
 
-#include "dpcon-cmd.h"
+#include "../include/dpcon.h"
 
 /**
  * dpcon_open() - Open a control session for the specified object
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
index e36da20..6170547 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
@@ -38,8 +38,8 @@
 #include <linux/msi.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/fsl/mc.h>
 
-#include "../../include/mc.h"
 #include "../../include/dpaa2-io.h"
 
 #include "qbman-portal.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
index e5d6674..bb4a99f 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
@@ -30,7 +30,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/types.h>
-#include "../../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "../../include/dpaa2-io.h"
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/staging/fsl-mc/bus/dpio/dpio.c
index d81e023..b16a990 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio.c
@@ -30,8 +30,8 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  * POSSIBILITY OF SUCH DAMAGE.
  */
-#include "../../include/mc-sys.h"
-#include "../../include/mc-cmd.h"
+#include <linux/fsl/mc-sys.h>
+#include <linux/fsl/mc-cmd.h>
 
 #include "dpio.h"
 #include "dpio-cmd.h"
diff --git a/drivers/staging/fsl-mc/include/dpbp.h b/include/linux/fsl/dpbp.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpbp.h
rename to include/linux/fsl/dpbp.h
diff --git a/drivers/staging/fsl-mc/bus/dpcon-cmd.h b/include/linux/fsl/dpcon-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpcon-cmd.h
rename to include/linux/fsl/dpcon-cmd.h
diff --git a/drivers/staging/fsl-mc/include/dpmng.h b/include/linux/fsl/dpmng.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpmng.h
rename to include/linux/fsl/dpmng.h
diff --git a/drivers/staging/fsl-mc/include/dprc.h b/include/linux/fsl/dprc.h
similarity index 99%
rename from drivers/staging/fsl-mc/include/dprc.h
rename to include/linux/fsl/dprc.h
index 2f4a7a7..135c87b 100644
--- a/drivers/staging/fsl-mc/include/dprc.h
+++ b/include/linux/fsl/dprc.h
@@ -305,4 +305,3 @@ int dprc_get_container_id(struct fsl_mc_io *mc_io,
 			  int *container_id);
 
 #endif /* _FSL_DPRC_H */
-
diff --git a/drivers/staging/fsl-mc/include/mc-bus.h b/include/linux/fsl/mc-bus.h
similarity index 99%
rename from drivers/staging/fsl-mc/include/mc-bus.h
rename to include/linux/fsl/mc-bus.h
index 42700de..23c06e1 100644
--- a/drivers/staging/fsl-mc/include/mc-bus.h
+++ b/include/linux/fsl/mc-bus.h
@@ -11,7 +11,7 @@
 #ifndef _FSL_MC_MCBUS_H_
 #define _FSL_MC_MCBUS_H_
 
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 #include <linux/mutex.h>
 
 struct irq_domain;
diff --git a/drivers/staging/fsl-mc/include/mc-cmd.h b/include/linux/fsl/mc-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/mc-cmd.h
rename to include/linux/fsl/mc-cmd.h
diff --git a/drivers/staging/fsl-mc/include/mc-sys.h b/include/linux/fsl/mc-sys.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/mc-sys.h
rename to include/linux/fsl/mc-sys.h
diff --git a/drivers/staging/fsl-mc/include/mc.h b/include/linux/fsl/mc.h
similarity index 99%
rename from drivers/staging/fsl-mc/include/mc.h
rename to include/linux/fsl/mc.h
index 1c46c0c..929bfdb 100644
--- a/drivers/staging/fsl-mc/include/mc.h
+++ b/include/linux/fsl/mc.h
@@ -14,7 +14,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
-#include "../include/dprc.h"
+#include <linux/fsl/dprc.h>
 
 #define FSL_MC_VENDOR_FREESCALE	0x1957
 
-- 
2.9.4
