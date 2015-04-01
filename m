From: heiko@sntech.de (Heiko Stuebner)
Date: Wed,  1 Apr 2015 12:09:37 +0200
Subject: [PATCH RFC v2 03/12] drm: add components subdirectory and
 infrastructure
In-Reply-To: <1427882986-19110-1-git-send-email-heiko@sntech.de>
References: <1427882986-19110-1-git-send-email-heiko@sntech.de>
Message-ID: <1427882986-19110-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until there are only the specialized bridge and i2c directories available
to hold generic support code like external components. But as there are
also things like external encoders that do not use i2c, those do not match
all cases.
Therefore introduce a new subdirectories to hold generic components like the
mentioned external encoders that can be used by component-based drm drivers.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/Kconfig             | 2 ++
 drivers/gpu/drm/Makefile            | 1 +
 drivers/gpu/drm/components/Kconfig  | 4 ++++
 drivers/gpu/drm/components/Makefile | 1 +
 4 files changed, 8 insertions(+)
 create mode 100644 drivers/gpu/drm/components/Kconfig
 create mode 100644 drivers/gpu/drm/components/Makefile

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 151a050..2f454f4 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -81,6 +81,8 @@ source "drivers/gpu/drm/i2c/Kconfig"
 
 source "drivers/gpu/drm/bridge/Kconfig"
 
+source "drivers/gpu/drm/components/Kconfig"
+
 config DRM_TDFX
 	tristate "3dfx Banshee/Voodoo3+"
 	depends on DRM && PCI
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c239b9..aa9ccaa 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -69,3 +69,4 @@ obj-$(CONFIG_DRM_IMX) += imx/
 obj-y			+= i2c/
 obj-y			+= panel/
 obj-y			+= bridge/
+obj-y			+= components/
diff --git a/drivers/gpu/drm/components/Kconfig b/drivers/gpu/drm/components/Kconfig
new file mode 100644
index 0000000..9d5d462
--- /dev/null
+++ b/drivers/gpu/drm/components/Kconfig
@@ -0,0 +1,4 @@
+menu "Standalone components for use with the component framework"
+     depends on DRM && DRM_KMS_HELPER
+
+endmenu
diff --git a/drivers/gpu/drm/components/Makefile b/drivers/gpu/drm/components/Makefile
new file mode 100644
index 0000000..be16eca
--- /dev/null
+++ b/drivers/gpu/drm/components/Makefile
@@ -0,0 +1 @@
+ccflags-y := -Iinclude/drm
-- 
2.1.4
