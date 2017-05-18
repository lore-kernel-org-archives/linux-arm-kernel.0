From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 18 May 2017 16:31:30 +0530
Subject: [PATCH 1/2] ARM: davinci_all_defconfig: cleanup with savedefconfig
In-Reply-To: <cover.1495104570.git.nsekhar@ti.com>
References: <cover.1495104570.git.nsekhar@ti.com>
Message-ID: <f6b8224820c9859d42fc397a15540f123bb7065d.1495104570.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

davinci_all_defconfig is out of sync with savedefconfig in some places.
Regenerate the default settings by:

$ make davinci_all_config
$ make savedefconfig
$ cp defconfig arch/arm/configs/davinci_all_defconfig

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/configs/davinci_all_defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 67db82999c06..d8cdcfaa0206 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -83,14 +83,13 @@ CONFIG_NETCONSOLE=y
 CONFIG_TUN=m
 CONFIG_DM9000=y
 CONFIG_TI_DAVINCI_EMAC=y
+CONFIG_LSI_ET1011C_PHY=y
 CONFIG_LXT_PHY=y
 CONFIG_SMSC_PHY=y
-CONFIG_LSI_ET1011C_PHY=y
 CONFIG_PPP=m
 CONFIG_PPP_DEFLATE=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-# CONFIG_INPUT_MOUSEDEV is not set
 CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_EVBUG=m
 CONFIG_KEYBOARD_ATKBD=m
@@ -236,7 +235,6 @@ CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=m
 CONFIG_DEBUG_FS=y
-CONFIG_TIMER_STATS=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_ARM_UNWIND is not set
-- 
2.9.0
