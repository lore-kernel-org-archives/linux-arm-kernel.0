From: jon.mason@broadcom.com (Jon Mason)
Date: Fri, 28 Apr 2017 16:11:29 -0400
Subject: [PATCH v3 1/3] ARM: BCM: Enable thermal support for NSP SoCs
In-Reply-To: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
References: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1493410291-16679-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the Northstar Plus Kconfig to select THERMAL and THERMAL_OF,
which allows the ns-thermal driver to be selected via menuconfig.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index a0e66d8..93a61d0 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -44,6 +44,8 @@ config ARCH_BCM_NSP
 	select ARM_ERRATA_775420
 	select ARM_ERRATA_764369 if SMP
 	select HAVE_SMP
+	select THERMAL
+	select THERMAL_OF
 	help
 	  Support for Broadcom Northstar Plus SoC.
 	  Broadcom Northstar Plus family of SoCs are used for switching control
-- 
2.7.4
