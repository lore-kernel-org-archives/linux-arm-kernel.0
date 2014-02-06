From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:25 +0900
Subject: [PATCH 05/13] ARM: shmobile: marzen: enable CONFIG_DEVTMPFS in
 defconfig
In-Reply-To: <cover.1391651074.git.horms+renesas@verge.net.au>
References: <cover.1391651074.git.horms+renesas@verge.net.au>
Message-ID: <edcde600a0bf778d98d945bd27f51c941e35bb8c.1391651074.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This reverts commit 41307133da4b6f242ecbb45950b9d043c0b21b96
("ARM: shmobile: marzen: Do not enable CONFIG_DEVTMPFS defconfig").

DEVTMPFS is needed for udev.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
[horms+renesas at verge.net.au: Added subject of reverted patch to changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index f21bd40..92994f7 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -43,6 +43,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
 # CONFIG_FW_LOADER is not set
-- 
1.8.5.2
