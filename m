From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed,  4 Jul 2012 11:14:04 +0300
Subject: [PATCH] remoteproc: fix missing CONFIG_FW_LOADER configurations
Message-ID: <1341389644-12834-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remoteproc requires user space firmware loading support, so
let's select FW_LOADER explicitly to avoid painful misconfigurations
(which only show up in runtime).

Cc: stable <stable@vger.kernel.org>
Reported-by: Mark Grosen <mgrosen@ti.com>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/remoteproc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index db4e39b..f8d818a 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -4,6 +4,7 @@ menu "Remoteproc drivers (EXPERIMENTAL)"
 config REMOTEPROC
 	tristate
 	depends on EXPERIMENTAL
+	select FW_CONFIG
 
 config OMAP_REMOTEPROC
 	tristate "OMAP remoteproc support"
-- 
1.7.9.5
