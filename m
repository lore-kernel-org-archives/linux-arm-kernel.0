From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 21 Nov 2015 19:04:53 +0100
Subject: [PATCH 6/6] pinctrl: activate pxa architecture
In-Reply-To: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
References: <1448129093-20722-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1448129093-20722-7-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the pxa architecture, at least for pxa27x, supports pin control,
activate it in the pinctrl tree.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/pinctrl/Kconfig  | 1 +
 drivers/pinctrl/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index b422e4ed73f4..cab84911466a 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -254,6 +254,7 @@ source "drivers/pinctrl/freescale/Kconfig"
 source "drivers/pinctrl/intel/Kconfig"
 source "drivers/pinctrl/mvebu/Kconfig"
 source "drivers/pinctrl/nomadik/Kconfig"
+source "drivers/pinctrl/pxa/Kconfig"
 source "drivers/pinctrl/qcom/Kconfig"
 source "drivers/pinctrl/samsung/Kconfig"
 source "drivers/pinctrl/sh-pfc/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 738cb4929a49..d214ede807e0 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -46,6 +46,7 @@ obj-y				+= freescale/
 obj-$(CONFIG_X86)		+= intel/
 obj-$(CONFIG_PLAT_ORION)        += mvebu/
 obj-y				+= nomadik/
+obj-$(CONFIG_ARCH_PXA)		+= pxa/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_PINCTRL_SAMSUNG)	+= samsung/
 obj-$(CONFIG_PINCTRL_SH_PFC)	+= sh-pfc/
-- 
2.1.4
