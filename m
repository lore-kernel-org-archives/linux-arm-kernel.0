From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:51:51 +0100
Subject: [PATCH 3/3] ARM: shmobile: defconfig: Disable CONFIG_EMBEDDED
In-Reply-To: <cover.1521206439.git.horms+renesas@verge.net.au>
References: <cover.1521206439.git.horms+renesas@verge.net.au>
Message-ID: <a20d1390c1daac4b8ae1e544e1e49dfd386125a8.1521206439.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

CONFIG_EXPERT exposes too many config options that do not matter for
development.  E.g. it prohibits using the default values for the various
SH_SCI options.  However, CONFIG_EMBEDDED selects CONFIG_EXPERT, so it
cannot be disabled.

Hence disable CONFIG_EMBEDDED, and compensate for the loss of
CONFIG_DEBUG_KERNEL by enabling the latter.

Actual impact, all harmless:
  - CONFIG_NAMESPACES=y (plus a few related CONFIG_*_NS options),
  - CONFIG_SYSCTL_SYSCALL=n,
  - CONFIG_SERIAL_SH_SCI_NR_UARTS changed from 20 to 18,
  - Some HID support became enabled,
  - CONFIG_DEBUG_MEMORY_INIT=y,

Refresh the result.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index e3658ec04e83..a701601fbd76 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -5,8 +5,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_SYSCTL_SYSCALL=y
-CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 CONFIG_ARCH_RENESAS=y
@@ -103,7 +101,6 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EM=y
 CONFIG_SERIAL_SH_SCI=y
-CONFIG_SERIAL_SH_SCI_NR_UARTS=20
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_DEMUX_PINCTRL=y
@@ -164,7 +161,6 @@ CONFIG_FB_SH_MOBILE_MERAM=y
 # CONFIG_BACKLIGHT_GENERIC is not set
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_AS3711=y
-CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
@@ -225,4 +221,5 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
 # CONFIG_ARM_UNWIND is not set
-- 
2.11.0
