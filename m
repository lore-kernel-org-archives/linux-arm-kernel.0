From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 24 Apr 2013 15:34:23 +0200
Subject: [PATCH] cpuidle: add maintainer entry
Message-ID: <1366810463-17495-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the cpuidle drivers are spread across the different archs.

The patch submission for cpuidle are following different path: the cpuidle core
code goes to linux-pm, the ARM drivers goes to arm-soc or the SoC specific
tree, sh goes through sh arch tree, pseries goes through PowerPC and
finally intel goes through Len's tree while acpi_idle goes under linux-pm.

That makes difficult to consolidate the code and to propagate modifications
from the cpuidle core to the different drivers.

Hopefully, a movement has initiated to put the cpuidle drivers into the
drivers/cpuidle directory like cpuidle-calxeda.c and cpuidle-kirkwood.c

Add an explicit maintainer entry in the MAINTAINER to clarify the situation
and prevent new cpuidle drivers to goes to an arch directory.

The upstreaming process is unchanged: Rafael takes the patches to merge them
into its tree but with the acked-by from the driver's maintainer. So the header
must contains the name of the maintainer.

This organization will be the same than cpufreq.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS                        |    7 +++++++
 drivers/cpuidle/cpuidle-calxeda.c  |    4 +++-
 drivers/cpuidle/cpuidle-kirkwood.c |    5 +++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61677c3..effa0f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2206,6 +2206,13 @@ S:	Maintained
 F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
 
+CPUIDLE DRIVERS
+M:	Rafael J. Wysocki <rjw@sisk.pl>
+L:	linux-pm at vger.kernel.org
+S:	Maintained
+F:	drivers/cpuidle/*
+F:	include/linux/cpuidle.h
+
 CPU FREQUENCY DRIVERS - ARM BIG LITTLE
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 M:	Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
index e344b56..2378c39 100644
--- a/drivers/cpuidle/cpuidle-calxeda.c
+++ b/drivers/cpuidle/cpuidle-calxeda.c
@@ -1,7 +1,6 @@
 /*
  * Copyright 2012 Calxeda, Inc.
  *
- * Based on arch/arm/plat-mxc/cpuidle.c:
  * Copyright 2012 Freescale Semiconductor, Inc.
  * Copyright 2012 Linaro Ltd.
  *
@@ -16,6 +15,9 @@
  *
  * You should have received a copy of the GNU General Public License along with
  * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author    : Rob Herring <rob.herring@calxeda.com>
+ * Maintainer: Rob Herring <rob.herring@calxeda.com>
  */
 
 #include <linux/cpuidle.h>
diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
index 53290e1..521b0a7 100644
--- a/drivers/cpuidle/cpuidle-kirkwood.c
+++ b/drivers/cpuidle/cpuidle-kirkwood.c
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-kirkwood/cpuidle.c
- *
  * CPU idle Marvell Kirkwood SoCs
  *
  * This file is licensed under the terms of the GNU General Public
@@ -11,6 +9,9 @@
  * to implement two idle states -
  * #1 wait-for-interrupt
  * #2 wait-for-interrupt and DDR self refresh
+ *
+ * Maintainer: Jason Cooper <jason@lakedaemon.net>
+ * Maintainer: Andrew Lunn <andrew@lunn.ch>
  */
 
 #include <linux/kernel.h>
-- 
1.7.9.5
