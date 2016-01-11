From: balbi@ti.com (Felipe Balbi)
Date: Mon, 11 Jan 2016 15:26:12 -0600
Subject: [PATCH] arm: omap2plus_defconfig: enable SPLIT and DWARF4
Message-ID: <1452547572-23515-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_DEBUG_INFO_SPLIT will split debug info on
.dwo files. This will generate a smaller vmlinux and
smaller .ko modules, which will be easier to ship on
certain products.

CONFIG_DEBUG_INFO_DWARF4 will generate debug info in
DWARF4 format, which ends up being larger, but
improves the probability of resolving variables in
optmized code.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c5e1943e5427..0b3e471a4262 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -449,6 +449,8 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_SPLIT=y
+CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_SCHEDSTATS=y
 CONFIG_TIMER_STATS=y
-- 
2.7.0
