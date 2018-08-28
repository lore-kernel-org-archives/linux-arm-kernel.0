From: nm@ti.com (Nishanth Menon)
Date: Mon, 27 Aug 2018 19:50:56 -0500
Subject: [PATCH] clk: keystone: Enable TISCI clocks if K3_ARCH
Message-ID: <20180828005056.27326-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

K3_ARCH uses TISCI for clocks as well. Enable the same
for the driver support.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Ref: https://patchwork.kernel.org/patch/10447677/

Since ARCH_K3 only got integrated in v4.19-rc1, rebased to v4.19-rc1 tag..

 drivers/clk/Makefile         | 1 +
 drivers/clk/keystone/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index a84c5573cabe..ed344eb717cc 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
 obj-y					+= imgtec/
 obj-$(CONFIG_ARCH_MXC)			+= imx/
 obj-$(CONFIG_MACH_INGENIC)		+= ingenic/
+obj-$(CONFIG_ARCH_K3)			+= keystone/
 obj-$(CONFIG_ARCH_KEYSTONE)		+= keystone/
 obj-$(CONFIG_MACH_LOONGSON32)		+= loongson1/
 obj-y					+= mediatek/
diff --git a/drivers/clk/keystone/Kconfig b/drivers/clk/keystone/Kconfig
index 7e9f0176578a..b04927d06cd1 100644
--- a/drivers/clk/keystone/Kconfig
+++ b/drivers/clk/keystone/Kconfig
@@ -7,7 +7,7 @@ config COMMON_CLK_KEYSTONE
 
 config TI_SCI_CLK
 	tristate "TI System Control Interface clock drivers"
-	depends on (ARCH_KEYSTONE || COMPILE_TEST) && OF
+	depends on (ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST) && OF
 	depends on TI_SCI_PROTOCOL
 	default ARCH_KEYSTONE
 	---help---
-- 
2.15.1
