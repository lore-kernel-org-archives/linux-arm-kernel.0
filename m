From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  4 Jul 2018 13:43:32 +0200
Subject: [PATCH 4/5] ARM: shmobile: defconfig: Disable /sbin/hotplug fork-bomb
In-Reply-To: <20180704114333.27584-1-geert+renesas@glider.be>
References: <20180704114333.27584-1-geert+renesas@glider.be>
Message-ID: <20180704114333.27584-5-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No recent mainstream system uses the /sbin/hotplug fork-bomb any more.
Commit 7934779a69f1184f29d786b89e77dd14519bd226 ("Driver-Core: disable
/sbin/hotplug by default") disabled it in Kconfig, but the various
defconfigs weren't updated.

According to the systemd requirements, this option must be disabled, as
it slows down the system and confuses udev.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Extended commit message,
  - shmobile_defconfig is the only shmobile defconfig left.
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 7a5a970420b6353a..ac3dad3c3b9dc9c6 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -58,7 +58,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_CAN=y
 CONFIG_CAN_RCAR=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
-- 
2.17.1
