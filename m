From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 27 Apr 2017 17:23:12 -0400
Subject: [PATCH v2 1/3] ARM: BCM: Enable thermal support for iProc SoCs
In-Reply-To: <1493328194-1766-1-git-send-email-jon.mason@broadcom.com>
References: <1493328194-1766-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1493328194-1766-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the iProc Kconfig to select THERMAL and THERMAL_OF, which allows
the ns-thermal driver to be selected via menuconfig.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index a0e66d8..da2bfeb 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -19,6 +19,8 @@ config ARCH_BCM_IPROC
 	select GPIOLIB
 	select ARM_AMBA
 	select PINCTRL
+	select THERMAL
+	select THERMAL_OF
 	help
 	  This enables support for systems based on Broadcom IPROC architected SoCs.
 	  The IPROC complex contains one or more ARM CPUs along with common
-- 
2.7.4
