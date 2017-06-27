From: s-anna@ti.com (Suman Anna)
Date: Tue, 27 Jun 2017 17:46:10 -0500
Subject: [PATCH 4/4] remoteproc/keystone: Fix circular dependencies for ARM
 configs
In-Reply-To: <20170627224610.15321-1-s-anna@ti.com>
References: <20170627224610.15321-1-s-anna@ti.com>
Message-ID: <20170627224610.15321-5-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop the dependency on RESET_CONTROLLER for the Keystone remoteproc
driver to resolve some circular dependencies around different choices
for RESET_CONTROLLER on common ARM configs. This dependency is
inherent as the RESET_CONTROLLER will be enabled due to the enabled
ARCH_HAS_RESET_CONTROLLER for ARCH_KEYSTONE.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 945c1574f896..8891a8e50f12 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -70,7 +70,6 @@ config DA8XX_REMOTEPROC
 config KEYSTONE_REMOTEPROC
 	tristate "Keystone Remoteproc support"
 	depends on ARCH_KEYSTONE
-	depends on RESET_CONTROLLER
 	select RPMSG_VIRTIO
 	help
 	  Say Y here here to support Keystone remote processors (DSP)
-- 
2.13.1
