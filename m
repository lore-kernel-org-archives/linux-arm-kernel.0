From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Wed, 27 Apr 2016 09:11:44 -0500
Subject: [PATCH 1/5] ARM: Keystone: Enable PINCTRL for Keystone ARCH
In-Reply-To: <1461766308-27669-1-git-send-email-fcooper@ti.com>
References: <1461766308-27669-1-git-send-email-fcooper@ti.com>
Message-ID: <1461766308-27669-2-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Some Keystone 2 devices utilize pinmuxing which requires PINCTRL
to be enabled. Therefore, enable PINCTRL for all Keystone 2 devices.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-keystone/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index ea955f6db..7a432ee 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -11,6 +11,7 @@ config ARCH_KEYSTONE
 	select ZONE_DMA if ARM_LPAE
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
+	select PINCTRL
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
-- 
2.7.0
