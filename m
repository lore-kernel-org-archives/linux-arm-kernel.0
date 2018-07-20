From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:03:53 +0200
Subject: [PATCH 5/7] ARM: shmobile: defconfig: Disable /sbin/hotplug fork-bomb
In-Reply-To: <cover.1532086504.git.horms+renesas@verge.net.au>
References: <cover.1532086504.git.horms+renesas@verge.net.au>
Message-ID: <c9619bca1edc7176e9ba5924f1c348e318a85a12.1532086504.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

No recent mainstream system uses the /sbin/hotplug fork-bomb any more.
Commit 7934779a69f1184f29d786b89e77dd14519bd226 ("Driver-Core: disable
/sbin/hotplug by default") disabled it in Kconfig, but the various
defconfigs weren't updated.

According to the systemd requirements, this option must be disabled, as
it slows down the system and confuses udev.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 7a5a970420b6..ac3dad3c3b9d 100644
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
2.11.0
