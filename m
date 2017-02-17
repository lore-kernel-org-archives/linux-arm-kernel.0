From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 18 Feb 2017 01:37:15 +0800
Subject: [PATCH 2/9] pinctrl: sunxi: rename sun7i-a20 driver to sunxi-a20-r40
In-Reply-To: <20170217173722.6477-1-icenowy@aosc.xyz>
References: <20170217173722.6477-1-icenowy@aosc.xyz>
Message-ID: <20170217173722.6477-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new R40 SoC come with a largely similar version of the pin
controller in A20.

Rename the driver, in order to extend it with R40 support.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/pinctrl/sunxi/Kconfig                                          | 2 +-
 drivers/pinctrl/sunxi/Makefile                                         | 2 +-
 drivers/pinctrl/sunxi/{pinctrl-sun7i-a20.c => pinctrl-sunxi-a20-r40.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/pinctrl/sunxi/{pinctrl-sun7i-a20.c => pinctrl-sunxi-a20-r40.c} (100%)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 92d845827577..6552cfd5c057 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -26,7 +26,7 @@ config PINCTRL_SUN6I_A31_R
 	depends on RESET_CONTROLLER
 	select PINCTRL_SUNXI
 
-config PINCTRL_SUN7I_A20
+config PINCTRL_SUNXI_A20_R40
 	def_bool MACH_SUN7I
 	select PINCTRL_SUNXI
 
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index f9a3855c42f1..6ceab91c3834 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PINCTRL_SUN5I)		+= pinctrl-sun5i.o
 obj-$(CONFIG_PINCTRL_SUN6I_A31)		+= pinctrl-sun6i-a31.o
 obj-$(CONFIG_PINCTRL_SUN6I_A31S)	+= pinctrl-sun6i-a31s.o
 obj-$(CONFIG_PINCTRL_SUN6I_A31_R)	+= pinctrl-sun6i-a31-r.o
-obj-$(CONFIG_PINCTRL_SUN7I_A20)		+= pinctrl-sun7i-a20.o
+obj-$(CONFIG_PINCTRL_SUNXI_A20_R40)	+= pinctrl-sunxi-a20-r40.o
 obj-$(CONFIG_PINCTRL_SUN8I_A23)		+= pinctrl-sun8i-a23.o
 obj-$(CONFIG_PINCTRL_SUN8I_A23_R)	+= pinctrl-sun8i-a23-r.o
 obj-$(CONFIG_PINCTRL_SUN8I_A33)		+= pinctrl-sun8i-a33.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c b/drivers/pinctrl/sunxi/pinctrl-sunxi-a20-r40.c
similarity index 100%
rename from drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
rename to drivers/pinctrl/sunxi/pinctrl-sunxi-a20-r40.c
-- 
2.11.1
