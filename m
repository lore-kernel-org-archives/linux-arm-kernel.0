From: s-anna@ti.com (Suman Anna)
Date: Mon, 17 Jul 2017 22:26:44 -0500
Subject: [PATCH 1/3] ARM: configs: keystone: Enable Message Manager
In-Reply-To: <20170718032646.29389-1-s-anna@ti.com>
References: <20170718032646.29389-1-s-anna@ti.com>
Message-ID: <20170718032646.29389-2-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

Message Manager is a communication hardware block on 66AK2G[1] SoCs.
Enable the same to provide support for communication with 66AK2G Power
Management Micro Controller (PMMC) via the TISCI protocol[2].

[1] http://www.ti.com/product/66ak2g02
[2] http://processors.wiki.ti.com/index.php/TISCI

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 1331f6dc456a..1a56a4000a14 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -174,6 +174,8 @@ CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
+CONFIG_MAILBOX=y
+CONFIG_TI_MESSAGE_MANAGER=y
 CONFIG_SOC_TI=y
 CONFIG_KEYSTONE_NAVIGATOR_QMSS=y
 CONFIG_KEYSTONE_NAVIGATOR_DMA=y
-- 
2.13.1
