From: marex@denx.de (Marek Vasut)
Date: Thu,  5 May 2016 22:31:35 +0200
Subject: [PATCH] ARM: at91: sama5: Update defconfig
Message-ID: <1462480295-8034-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CGROUPS support, so we can boot userspace that uses systemd on
top of kernel configured using this defconfig. The systemd userspace
depends on cgroups and without them, it dies in mysterious ways.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index afbda41..1b60be2 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -3,6 +3,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
-- 
2.7.0
