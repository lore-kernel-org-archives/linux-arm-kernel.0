From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 3 Aug 2012 15:12:34 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Remove CONFIG_DEFAULT_MMAP_MIN_ADDR
Message-ID: <1344017554-4120-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By default CONFIG_DEFAULT_MMAP_MIN_ADDR is 4096 and can also be changed via
/proc/sys/vm/mmap_min_addr if needed.

Quoting Russell King (http://marc.info/?l=linux-arm-kernel&m=134401593807820&w=2):

"4096 is also fine for ARM too.  There's not much point in having
defconfigs change it - that would just be pure noise in the config
files."

,so remove CONFIG_DEFAULT_MMAP_MIN_ADDR from the defconfig file.
 
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f725b96..13bcfb1 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -42,7 +42,6 @@ CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
-CONFIG_DEFAULT_MMAP_MIN_ADDR=32768
 CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
 CONFIG_VFP=y
 CONFIG_NEON=y
-- 
1.7.1
