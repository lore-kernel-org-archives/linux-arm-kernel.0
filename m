From: s-anna@ti.com (Suman Anna)
Date: Mon, 17 Jul 2017 22:26:45 -0500
Subject: [PATCH 2/3] ARM: configs: keystone: Enable TI-SCI protocol and genpd
 driver
In-Reply-To: <20170718032646.29389-1-s-anna@ti.com>
References: <20170718032646.29389-1-s-anna@ti.com>
Message-ID: <20170718032646.29389-3-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

Enable the TI-SCI core protocol and the corresponding genpd
driver to enable the essential infrastructure for various
device drivers on the 66AK2G family of SoCs. The TI-SCI Clock
driver is automatically enabled for ARCH_KEYSTONE.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 1a56a4000a14..40bc47171193 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -179,9 +179,11 @@ CONFIG_TI_MESSAGE_MANAGER=y
 CONFIG_SOC_TI=y
 CONFIG_KEYSTONE_NAVIGATOR_QMSS=y
 CONFIG_KEYSTONE_NAVIGATOR_DMA=y
+CONFIG_TI_SCI_PM_DOMAINS=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=y
 CONFIG_KEYSTONE_IRQ=y
+CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_FANOTIFY=y
-- 
2.13.1
