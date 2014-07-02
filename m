From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  2 Jul 2014 14:56:17 +0200
Subject: [PATCH 1/2] ARM: kirkwood: add appended DTB support in
 kirkwood_defconfig
Message-ID: <1404305778-17757-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the Kirkwood platforms use fairly old bootloaders that don't
have Device Tree support, so it makes sense to enable appended DTB
support by default, as well as the backward compatibility with ATAGS
passed by the bootloader for those platforms. It helps having a
defconfig that works fine out of the box for most Kirkwood platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/kirkwood_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index b9e480c..2da96bc 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -30,6 +30,8 @@ CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
-- 
2.0.0
