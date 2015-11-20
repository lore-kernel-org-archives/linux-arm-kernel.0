From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Fri, 20 Nov 2015 02:46:19 +0100
Subject: [PATCH v2 3/3] ARM: sunxi: Clean up sunxi_defconfig
In-Reply-To: <1447983979-12751-1-git-send-email-public_timo.s@silentcreek.de>
References: <1447724578-4786-1-git-send-email-public_timo.s@silentcreek.de>
 <1447983979-12751-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <1447983979-12751-3-git-send-email-public_timo.s@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up sunxi_defconfig by generating a fresh file via
  make sunxi_defconfig
  make savedefconfig

While this moves around a few lines and removes unnecessary symbols,
it doesn't introduce any functional changes. The resulting .config is
identical before and after this patch.

Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
---
 arch/arm/configs/sunxi_defconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 90252ca..95b51fc 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -11,14 +11,12 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=8
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-CONFIG_HIGHPTE=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_VFP=y
 CONFIG_NEON=y
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -60,12 +58,12 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_WLAN is not set
 # CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_KEYBOARD_SUN4I_LRADC=y
 # CONFIG_INPUT_MOUSE is not set
-CONFIG_INPUT_MISC=y
-CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_INPUT_TOUCHSCREEN=y
-CONFIG_KEYBOARD_SUN4I_LRADC=y
 CONFIG_TOUCHSCREEN_SUN4I=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_AXP20X_PEK=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=8
-- 
2.1.4
