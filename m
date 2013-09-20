From: olof@lixom.net (Olof Johansson)
Date: Thu, 19 Sep 2013 17:56:33 -0700
Subject: [PATCH] ARM: tegra_defconfig: enable CONFIG_ARM_APPENDED_DTB
Message-ID: <1379638594-28888-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed on TrimSlice, since the u-boot on that hardware is too old
to support native device tree booting. Same for any device that currently
run fastboot, but none of that hardware is supported in mainline today;
or at least there are modern u-boot ports for it.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/configs/tegra_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index ea042e8..b694a09 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -39,6 +39,8 @@ CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
-- 
1.7.10.4
