From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jul 2018 14:04:21 +0200
Subject: [PATCH 4/5] ARM: shmobile: defconfig: Disable /sbin/hotplug fork-bomb
In-Reply-To: <cover.1532346690.git.horms+renesas@verge.net.au>
References: <cover.1532346690.git.horms+renesas@verge.net.au>
Message-ID: <bbb94a120136c4d8e0076d107f39fda14666ea65.1532346690.git.horms+renesas@verge.net.au>
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
index a0d88af9ec22..f8faf3729464 100644
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
