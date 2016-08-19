From: nm@ti.com (Nishanth Menon)
Date: Fri, 19 Aug 2016 18:12:35 -0500
Subject: [PATCH] ARM: configs: keystone: Enable Message Manager
Message-ID: <20160819231235.22296-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Message Manager is a communication hardware block on K2G[1] SoCs. Enable
the same to provide support for communication with K2G Power Management
Micro Controller(PMMC) via the TISCI protocol[2].

[1] http://www.ti.com/product/66ak2g02
[2] http://processors.wiki.ti.com/index.php/TISCI

Signed-off-by: Nishanth Menon <nm@ti.com>
---
based on v4.8-rc1
enables module introduced by: https://patchwork.kernel.org/patch/9290887/

 arch/arm/configs/keystone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index 71b42e66488a..de5a1d012289 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -172,6 +172,8 @@ CONFIG_LEDS_TRIGGER_BACKLIGHT=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
+CONFIG_MAILBOX=y
+CONFIG_TI_MESSAGE_MANAGER=y
 CONFIG_SOC_TI=y
 CONFIG_KEYSTONE_NAVIGATOR_QMSS=y
 CONFIG_KEYSTONE_NAVIGATOR_DMA=y
-- 
2.9.1.200.gb1ec08f
