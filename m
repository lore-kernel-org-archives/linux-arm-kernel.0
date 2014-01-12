From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 12:15:49 +0100
Subject: [PATCH] ARM: shmobile: koelsch: Enable DEVTMPFS_MOUNT in defconfig
Message-ID: <1389525349-3722-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Without this, a Debian jessie nfsroot hangs early in the boot process.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/configs/koelsch_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 8f283f725a12..7c06fbac21a7 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -36,6 +36,8 @@ CONFIG_UNIX=y
 CONFIG_INET=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_M25P80=y
 CONFIG_NETDEVICES=y
-- 
1.7.9.5
