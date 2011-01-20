From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 20 Jan 2011 15:02:59 -0200
Subject: [PATCH] mmc: mmc_mxc: Allow selection only for the correct platforms
Message-ID: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently MMC_MXC driver can be selected by all i.MX devices.

Restrict its use only for the appropriate processors.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d618e86..a3a9ec1 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -288,7 +288,7 @@ config MMC_MSM
 
 config MMC_MXC
 	tristate "Freescale i.MX2/3 Multimedia Card Interface support"
-	depends on ARCH_MXC
+	depends on MACH_MX21 || MACH_MX27 || ARCH_MX31
 	help
 	  This selects the Freescale i.MX2/3 Multimedia card Interface.
 	  If you have a i.MX platform with a Multimedia Card slot,
-- 
1.6.0.4
