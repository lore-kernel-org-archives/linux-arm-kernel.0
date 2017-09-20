From: s-anna@ti.com (Suman Anna)
Date: Wed, 20 Sep 2017 13:01:32 -0500
Subject: [PATCH] ARM: davinci_all_defconfig: enable CMA options
Message-ID: <20170920180132.4373-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the CMA and DMA_CMA Kconfig options by default for
Davinci platforms. Davinci remoteproc driver is one of the
modules that depends on these options, and this allows the
driver to be made visible for selection with menuconfig.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
Hi Sekhar,

Here's the patch that enables CMA as per your request. Patch based
on your v4.15/defconfig branch.

regards
Suman

 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 4d432cf1ee79..bd0cf22f9ceb 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -34,6 +34,7 @@ CONFIG_DAVINCI_MUX_WARNINGS=y
 CONFIG_DAVINCI_RESET_CLOCKS=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
+CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
@@ -56,6 +57,7 @@ CONFIG_NETFILTER=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER is not set
+CONFIG_DMA_CMA=y
 CONFIG_DA8XX_MSTPRI=y
 CONFIG_MTD=m
 CONFIG_MTD_TESTS=m
-- 
2.13.1
