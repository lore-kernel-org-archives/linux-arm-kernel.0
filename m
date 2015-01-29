From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 29 Jan 2015 10:12:48 -0500
Subject: [PATCH] ARM: keystone: defconfig: add DEVTMPFS option by default.
Message-ID: <1422544368-15861-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using network driver on keystone and nfs rootfs is used following
error displayed and device halts.

Missing devtmpfs, which is required for udev to run
Halting...

Add the DEVTMPFS option by default to fix this

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/configs/keystone_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 4446621..f9ebe61 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -209,3 +209,4 @@ CONFIG_KEYSTONE_IRQ=y
 CONFIG_GPIO_SYSCON=y
 CONFIG_TI_DAVINCI_MDIO=y
 CONFIG_MARVELL_PHY=y
+CONFIG_DEVTMPFS=y
-- 
1.7.9.5
