From: s-anna@ti.com (Suman Anna)
Date: Mon, 17 Jul 2017 22:26:46 -0500
Subject: [PATCH 3/3] ARM: configs: keystone: Enable reset drivers
In-Reply-To: <20170718032646.29389-1-s-anna@ti.com>
References: <20170718032646.29389-1-s-anna@ti.com>
Message-ID: <20170718032646.29389-4-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the TI SYSCON and TI-SCI reset drivers for Keystone
platforms. These drivers will provide the reset functionality
for devices like DSPs or PRU-ICSSs. There are no devices that
require these to be built-in, so these are enabled as modules.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 40bc47171193..d47ea43d097e 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -183,6 +183,8 @@ CONFIG_TI_SCI_PM_DOMAINS=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=y
 CONFIG_KEYSTONE_IRQ=y
+CONFIG_RESET_TI_SCI=m
+CONFIG_RESET_TI_SYSCON=m
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
2.13.1
