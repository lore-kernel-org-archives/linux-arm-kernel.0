From: zalan.blenessy@gmail.com (Zalan Blenessy)
Date: Wed,  1 Jan 2014 18:02:55 +0100
Subject: [PATCHv2 1/1] ARM: sunxi: select ARM_PSCI
In-Reply-To: <1387973466-5067-1-git-send-email-zalan.blenessy@gmail.com>
References: <1387973466-5067-1-git-send-email-zalan.blenessy@gmail.com>
Message-ID: <1388595775-20737-1-git-send-email-zalan.blenessy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Allwinner sun7i (A20) SoCs, the SMP operations are implemented in 
u-boot, and exposed to the kernel through PSCI. 

We thus need to enable PSCI support for Allwinner SoCs so that the 
kernel uses it to bring up the additionnal cores.

Signed-off-by: Signed-off-by: Zalan Blenessy <zalan.blenessy@gmail.com>
---
Changes[v2]:
 - Improved patch description

 arch/arm/mach-sunxi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 547004c..09df4b81 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -3,6 +3,7 @@ config ARCH_SUNXI
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
+	select ARM_PSCI
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select COMMON_CLK
-- 
1.7.10.4
