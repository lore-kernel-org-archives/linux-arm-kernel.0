From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun,  6 Dec 2015 12:45:56 +0200
Subject: [PATCH v2 4/5] clk: lpc18xx: add NXP specific COMMON_CLK_NXP
 configuration symbol
In-Reply-To: <1449398757-16834-1-git-send-email-vz@mleia.com>
References: <1449398757-16834-1-git-send-email-vz@mleia.com>
Message-ID: <1449398757-16834-5-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds COMMON_CLK_NXP configuration symbol and enables it for
NXP LPC18XX architecture, this is needed to reuse drivers/clk/nxp
folder for NXP common clock framework drivers other than LPC18XX one.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Acked-by: Joachim Eastwood <manabian@gmail.com>
---
Changes from v1 to v2:
- removed explicit COMMON_CLK selection for NXP LPC18xx

 drivers/clk/Kconfig  | 5 +++++
 drivers/clk/Makefile | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c3e3a02..7fc1eb9 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -175,6 +175,11 @@ config COMMON_CLK_PWM
 	  Adapter driver so that any PWM output can be (mis)used as clock signal
 	  at 50% duty cycle.
 
+config COMMON_CLK_NXP
+	def_bool COMMON_CLK && ARCH_LPC18XX
+	---help---
+	  Support for clock providers on NXP platforms.
+
 config COMMON_CLK_PXA
 	def_bool COMMON_CLK && ARCH_PXA
 	---help---
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 820714c..15603c1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -62,8 +62,8 @@ endif
 obj-$(CONFIG_PLAT_ORION)		+= mvebu/
 obj-$(CONFIG_ARCH_MESON)		+= meson/
 obj-$(CONFIG_ARCH_MXS)			+= mxs/
-obj-$(CONFIG_ARCH_LPC18XX)		+= nxp/
 obj-$(CONFIG_MACH_PISTACHIO)		+= pistachio/
+obj-$(CONFIG_COMMON_CLK_NXP)		+= nxp/
 obj-$(CONFIG_COMMON_CLK_PXA)		+= pxa/
 obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
-- 
2.1.4
