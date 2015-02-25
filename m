From: ezequiel.garcia@imgtec.com (Ezequiel Garcia)
Date: Wed, 25 Feb 2015 08:45:16 -0300
Subject: [PATCH 4/7] efuse: Move Tegra efuse driver
In-Reply-To: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
Message-ID: <1424864719-3390-5-git-send-email-ezequiel.garcia@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the efuse subsystem has been introduced, move the Tegra efuse driver
from drivers/soc/tegra/fuse/ to drivers/efuse/tegra. For now, there's no
generic efuse API. However, by having the drivers in a unified location it is
expected that such API will arise easier once support for more devices is added.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/efuse/Kconfig                                     | 7 +++++++
 drivers/efuse/Makefile                                    | 1 +
 drivers/{soc/tegra/fuse => efuse/tegra}/Makefile          | 0
 drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra.c      | 0
 drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra20.c    | 0
 drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra30.c    | 0
 drivers/{soc/tegra/fuse => efuse/tegra}/fuse.h            | 0
 drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra114.c | 0
 drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra124.c | 0
 drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra20.c  | 0
 drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra30.c  | 0
 drivers/{soc/tegra/fuse => efuse/tegra}/tegra-apbmisc.c   | 0
 drivers/soc/tegra/Makefile                                | 2 --
 13 files changed, 8 insertions(+), 2 deletions(-)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/Makefile (100%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra.c (100%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra20.c (100%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/fuse-tegra30.c (100%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/fuse.h (100%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra114.c (100%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra124.c (100%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra20.c (100%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/speedo-tegra30.c (100%)
 rename drivers/{soc/tegra/fuse => efuse/tegra}/tegra-apbmisc.c (100%)

diff --git a/drivers/efuse/Kconfig b/drivers/efuse/Kconfig
index 617476f..b84e06b 100644
--- a/drivers/efuse/Kconfig
+++ b/drivers/efuse/Kconfig
@@ -1,3 +1,10 @@
 menu "eFuse drivers"
 
+config EFUSE_TEGRA
+	bool
+	depends on ARCH_TEGRA
+	help
+	  Support for the eFuses available on Tegra SoCs
+
+
 endmenu
diff --git a/drivers/efuse/Makefile b/drivers/efuse/Makefile
index e69de29..b69a0d6 100644
--- a/drivers/efuse/Makefile
+++ b/drivers/efuse/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_EFUSE_TEGRA)	+= tegra/
diff --git a/drivers/soc/tegra/fuse/Makefile b/drivers/efuse/tegra/Makefile
similarity index 100%
rename from drivers/soc/tegra/fuse/Makefile
rename to drivers/efuse/tegra/Makefile
diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/efuse/tegra/fuse-tegra.c
similarity index 100%
rename from drivers/soc/tegra/fuse/fuse-tegra.c
rename to drivers/efuse/tegra/fuse-tegra.c
diff --git a/drivers/soc/tegra/fuse/fuse-tegra20.c b/drivers/efuse/tegra/fuse-tegra20.c
similarity index 100%
rename from drivers/soc/tegra/fuse/fuse-tegra20.c
rename to drivers/efuse/tegra/fuse-tegra20.c
diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/efuse/tegra/fuse-tegra30.c
similarity index 100%
rename from drivers/soc/tegra/fuse/fuse-tegra30.c
rename to drivers/efuse/tegra/fuse-tegra30.c
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/efuse/tegra/fuse.h
similarity index 100%
rename from drivers/soc/tegra/fuse/fuse.h
rename to drivers/efuse/tegra/fuse.h
diff --git a/drivers/soc/tegra/fuse/speedo-tegra114.c b/drivers/efuse/tegra/speedo-tegra114.c
similarity index 100%
rename from drivers/soc/tegra/fuse/speedo-tegra114.c
rename to drivers/efuse/tegra/speedo-tegra114.c
diff --git a/drivers/soc/tegra/fuse/speedo-tegra124.c b/drivers/efuse/tegra/speedo-tegra124.c
similarity index 100%
rename from drivers/soc/tegra/fuse/speedo-tegra124.c
rename to drivers/efuse/tegra/speedo-tegra124.c
diff --git a/drivers/soc/tegra/fuse/speedo-tegra20.c b/drivers/efuse/tegra/speedo-tegra20.c
similarity index 100%
rename from drivers/soc/tegra/fuse/speedo-tegra20.c
rename to drivers/efuse/tegra/speedo-tegra20.c
diff --git a/drivers/soc/tegra/fuse/speedo-tegra30.c b/drivers/efuse/tegra/speedo-tegra30.c
similarity index 100%
rename from drivers/soc/tegra/fuse/speedo-tegra30.c
rename to drivers/efuse/tegra/speedo-tegra30.c
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/efuse/tegra/tegra-apbmisc.c
similarity index 100%
rename from drivers/soc/tegra/fuse/tegra-apbmisc.c
rename to drivers/efuse/tegra/tegra-apbmisc.c
diff --git a/drivers/soc/tegra/Makefile b/drivers/soc/tegra/Makefile
index cdaad9d..23a0f64 100644
--- a/drivers/soc/tegra/Makefile
+++ b/drivers/soc/tegra/Makefile
@@ -1,4 +1,2 @@
-obj-$(CONFIG_ARCH_TEGRA) += fuse/
-
 obj-$(CONFIG_ARCH_TEGRA) += common.o
 obj-$(CONFIG_ARCH_TEGRA) += pmc.o
-- 
2.3.0
