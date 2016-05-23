From: j-keerthy@ti.com (Keerthy)
Date: Mon, 23 May 2016 17:59:06 +0530
Subject: [PATCH 2/3] arm: mach-keystone: Enable PINCTRL config
In-Reply-To: <1464006547-19569-1-git-send-email-j-keerthy@ti.com>
References: <1464006547-19569-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1464006547-19569-3-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

keystone-k2l uses pinmux and is compliant with PINCTRL_SINGLE
which depends on PINCTRL. Hence enable PINCTRL.

Signed-off-by: Keerthy <j-keerthy@ti.com>
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
1.9.1
