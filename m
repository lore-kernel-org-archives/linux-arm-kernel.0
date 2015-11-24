From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Nov 2015 20:45:24 +0900
Subject: [PATCH 3/3] pinctrl: spear: guard sub-directory with
 CONFIG_PINCTRL_SPEAR
In-Reply-To: <1448365524-12605-1-git-send-email-yamada.masahiro@socionext.com>
References: <1448365524-12605-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1448365524-12605-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_PINCTRL_SPEAR is more suitable than CONFIG_PLAT_SPEAR
to guard the drivers/pinctrl/spear/ directory.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/pinctrl/Makefile       | 2 +-
 drivers/pinctrl/spear/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index cdc4a61..22a02f3 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -49,7 +49,7 @@ obj-y				+= nomadik/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_PINCTRL_SAMSUNG)	+= samsung/
 obj-$(CONFIG_PINCTRL_SH_PFC)	+= sh-pfc/
-obj-$(CONFIG_PLAT_SPEAR)	+= spear/
+obj-$(CONFIG_PINCTRL_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
diff --git a/drivers/pinctrl/spear/Makefile b/drivers/pinctrl/spear/Makefile
index 0e400eb..37b8412 100644
--- a/drivers/pinctrl/spear/Makefile
+++ b/drivers/pinctrl/spear/Makefile
@@ -1,7 +1,7 @@
 # SPEAr pinmux support
 
 obj-$(CONFIG_PINCTRL_SPEAR_PLGPIO)	+= pinctrl-plgpio.o
-obj-$(CONFIG_PINCTRL_SPEAR)	+= pinctrl-spear.o
+obj-y				+= pinctrl-spear.o
 obj-$(CONFIG_PINCTRL_SPEAR3XX)	+= pinctrl-spear3xx.o
 obj-$(CONFIG_PINCTRL_SPEAR300)	+= pinctrl-spear300.o
 obj-$(CONFIG_PINCTRL_SPEAR310)	+= pinctrl-spear310.o
-- 
1.9.1
