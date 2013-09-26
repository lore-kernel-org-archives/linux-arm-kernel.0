From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 25 Sep 2013 21:18:15 -0400
Subject: [PATCH v3 3/3] clk: keystone: Build Keystone clock drivers
In-Reply-To: <1380158295-30629-1-git-send-email-santosh.shilimkar@ti.com>
References: <1380158295-30629-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1380158295-30629-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now build the keystone common clock drivers. The build is made
conditional based on COMMON_CLK_KEYSTONE

Cc: Mike Turquette <mturquette@linaro.org>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/clk/Kconfig           |    7 +++++++
 drivers/clk/Makefile          |    1 +
 drivers/clk/keystone/Makefile |    1 +
 3 files changed, 9 insertions(+)
 create mode 100644 drivers/clk/keystone/Makefile

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 279407a..10f85cc 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -93,6 +93,13 @@ config CLK_PPC_CORENET
 	  This adds the clock driver support for Freescale PowerPC corenet
 	  platforms using common clock framework.
 
+config COMMON_CLK_KEYSTONE
+	tristate "Clock drivers for Keystone based SOCs"
+	depends on ARCH_KEYSTONE && OF
+	---help---
+          Supports clock drivers for Keystone based SOCs. These SOCs have local
+	  a power sleep control module that gate the clock to the IPs and PLLs.
+
 endmenu
 
 source "drivers/clk/mvebu/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 7b11106..2a44d533 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
 obj-$(CONFIG_ARCH_ZYNQ)		+= zynq/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
+obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
 
 obj-$(CONFIG_X86)		+= x86/
 
diff --git a/drivers/clk/keystone/Makefile b/drivers/clk/keystone/Makefile
new file mode 100644
index 0000000..0477cf6
--- /dev/null
+++ b/drivers/clk/keystone/Makefile
@@ -0,0 +1 @@
+obj-y			+= pll.o gate.o
-- 
1.7.9.5
