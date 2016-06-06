From: j-keerthy@ti.com (Keerthy)
Date: Mon, 6 Jun 2016 10:15:05 +0530
Subject: [PATCH 2/3] arm: mach-keystone: Enable PINCTRL config
In-Reply-To: <1465188306-32556-1-git-send-email-j-keerthy@ti.com>
References: <1465188306-32556-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1465188306-32556-3-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Some Keystone 2 devices utilize pinmuxing which requires PINCTRL
to be enabled. Therefore, enable PINCTRL for all Keystone 2 devices.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
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
