From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Tue, 15 Apr 2014 10:20:39 +0300
Subject: [PATCH] ARM: mach-mxs: readd just removed select CLKSRC_OF
Message-ID: <1397546439-25153-1-git-send-email-lauri.hintsala@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MXS based apx4devkit doesn't boot with latest Linux v3.15-rc1
because commit ddb902cc34593ecb88c368f6e15db3cf829c56fe removed
"select CLKSRC_OF" from the machine config.

CC: linux-arm-kernel at lists.infradead.org
CC: Rob Herring <robh@kernel.org>
CC: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
---
I think commit ddb902cc34593ecb88c368f6e15db3cf829c56fe might break
also other armv4/5 based boards which are using CLKSRC_OF. There is
already patch for MOXA ART SoCs: https://lkml.org/lkml/2014/4/11/308

 arch/arm/mach-mxs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 8479413..b3eb28c 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -17,6 +17,7 @@ config ARCH_MXS
 	depends on ARCH_MULTI_V5
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
+	select CLKSRC_OF
 	select PINCTRL
 	select SOC_BUS
 	select SOC_IMX23
-- 
1.8.3.2
