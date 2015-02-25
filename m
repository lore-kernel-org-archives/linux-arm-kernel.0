From: ezequiel.garcia@imgtec.com (Ezequiel Garcia)
Date: Wed, 25 Feb 2015 08:45:15 -0300
Subject: [PATCH 3/7] drivers: Introduce new eFuse subsystem stub
In-Reply-To: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1424864719-3390-1-git-send-email-ezequiel.garcia@imgtec.com>
Message-ID: <1424864719-3390-4-git-send-email-ezequiel.garcia@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit introduces a new eFuse subsystem stub to hold all the eFuse-like
device drivers. This will be used to host the currently supported Tegra
eFuse driver, and will allow to add support for other platforms as well.

Cc: Thierry Reding <treding@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/Kconfig        | 2 ++
 drivers/Makefile       | 1 +
 drivers/efuse/Kconfig  | 3 +++
 drivers/efuse/Makefile | 0
 4 files changed, 6 insertions(+)
 create mode 100644 drivers/efuse/Kconfig
 create mode 100644 drivers/efuse/Makefile

diff --git a/drivers/Kconfig b/drivers/Kconfig
index c0cc96b..9c0d93d 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -146,6 +146,8 @@ source "drivers/remoteproc/Kconfig"
 
 source "drivers/rpmsg/Kconfig"
 
+source "drivers/efuse/Kconfig"
+
 source "drivers/soc/Kconfig"
 
 source "drivers/devfreq/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 527a6da..5572728 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -34,6 +34,7 @@ obj-y				+= amba/
 obj-$(CONFIG_DMADEVICES)	+= dma/
 
 # SOC specific infrastructure drivers.
+obj-y				+= efuse/
 obj-y				+= soc/
 
 obj-$(CONFIG_VIRTIO)		+= virtio/
diff --git a/drivers/efuse/Kconfig b/drivers/efuse/Kconfig
new file mode 100644
index 0000000..617476f
--- /dev/null
+++ b/drivers/efuse/Kconfig
@@ -0,0 +1,3 @@
+menu "eFuse drivers"
+
+endmenu
diff --git a/drivers/efuse/Makefile b/drivers/efuse/Makefile
new file mode 100644
index 0000000..e69de29
-- 
2.3.0
