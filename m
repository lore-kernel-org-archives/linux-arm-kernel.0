From: trini@ti.com (Tom Rini)
Date: Mon,  1 Jul 2013 09:13:13 -0400
Subject: [PATCH] ARM: OMAP2+: omap2plus_defconfig: Enable appended DTB support
Message-ID: <1372684393-19025-1-git-send-email-trini@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As this config must support boards which cannot support separate device
trees, enable support for appended ones.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Tom Rini <trini@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index abbe319..ec4deb9 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -34,6 +34,8 @@ CONFIG_NR_CPUS=2
 CONFIG_LEDS=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200"
 CONFIG_KEXEC=y
 CONFIG_FPE_NWFPE=y
-- 
1.7.9.5
