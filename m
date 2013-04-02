From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue,  2 Apr 2013 17:39:06 +1300
Subject: [PATCHv4 2/6] arm: vt8500: Increase available GPIOs on arch-vt8500
In-Reply-To: <1364877550-25921-1-git-send-email-linux@prisktech.co.nz>
References: <1364877550-25921-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1364877550-25921-3-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the inclusion of the pin control driver, more GPIO pins have been
identified on the arch-vt8500 SoCs requiring an increase in the available
GPIOs.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 13b7394..244c618 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1661,7 +1661,8 @@ config ARCH_NR_GPIO
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
 	default 512 if SOC_OMAP5
 	default 355 if ARCH_U8500
-	default 288 if ARCH_VT8500 || ARCH_SUNXI
+	default 352 if ARCH_VT8500
+	default 288 if ARCH_SUNXI
 	default 264 if MACH_H4700
 	default 0
 	help
-- 
1.7.9.5
