From: nm@ti.com (Nishanth Menon)
Date: Tue, 5 Jun 2018 01:20:46 -0500
Subject: [RFC PATCH] clk: keystone: Enable TISCI clocks if K3_ARCH
Message-ID: <20180605062046.31437-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

K3_ARCH uses TISCI for clocks as well. Enable the same
for the driver support.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Hi,

This patch depends on https://marc.info/?l=linux-arm-kernel&m=152817866312732&w=2
and is an RFC based off next-20180604 and will post formally once
v4.18-rc1 is available.

The consolidated series is also available at:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/next-20180604/k3-3-am6-clk

 drivers/clk/Makefile         | 1 +
 drivers/clk/keystone/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 0bb25dd009d1..c14187526b46 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
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
