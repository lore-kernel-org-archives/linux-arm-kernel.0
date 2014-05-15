From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 15 May 2014 10:55:13 +0200
Subject: [PATCH v5 5/5] ARM: sunxi: select MFD_SUN6I_PRCM when sun6i arch
 support is enabled
In-Reply-To: <1400144113-27659-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1400144113-27659-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1400144113-27659-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select the MFD_SUN6I_PRCM option when sun6i arch is enabled in order to get
the PRCM (Power/Reset/Clock Management) related drivers compiled.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 3aff966..0fbd4f1 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -23,6 +23,7 @@ config MACH_SUN6I
 	default ARCH_SUNXI
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_GIC
+	select MFD_SUN6I_PRCM
 	select RESET_CONTROLLER
 	select SUN5I_HSTIMER
 
-- 
1.8.3.2
