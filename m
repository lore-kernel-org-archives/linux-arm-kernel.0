From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:01:39 -0700
Subject: [PATCH 13/15] pinctrl: sunxi: Introduce per-driver Kconfig options
In-Reply-To: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1398711701-11309-14-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add one Kconfig option for each driver. This will allow to better control which
driver is enabled, instead of having either all or nothing.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/Kconfig  | 24 ++++++++++++++++++++++++
 drivers/pinctrl/sunxi/Makefile | 12 ++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 9d7d5106d85a..3940d098d6cb 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -5,4 +5,28 @@ config PINCTRL_SUNXI
 	select PINMUX
 	select GENERIC_PINCONF
 
+config PINCTRL_SUN4I_A10
+       bool
+       select PINCTRL_SUNXI
+
+config PINCTRL_SUN5I_A10S
+       bool
+       select PINCTRL_SUNXI
+
+config PINCTRL_SUN5I_A13
+       bool
+       select PINCTRL_SUNXI
+
+config PINCTRL_SUN6I_A31
+       bool
+       select PINCTRL_SUNXI
+
+config PINCTRL_SUN6I_A31_R
+       bool
+       select PINCTRL_SUNXI
+
+config PINCTRL_SUN7I_A20
+       bool
+       select PINCTRL_SUNXI
+
 endif
diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index 19dc3dab37c0..8e23a15e695d 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -2,9 +2,9 @@
 obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sunxi.o
 
 # SoC Drivers
-obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sun4i-a10.o
-obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sun5i-a10s.o
-obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sun5i-a13.o
-obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sun6i-a31.o
-obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sun6i-a31-r.o
-obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sun7i-a20.o
+obj-$(CONFIG_PINCTRL_SUN4I_A10)		+= pinctrl-sun4i-a10.o
+obj-$(CONFIG_PINCTRL_SUN5I_A10S)	+= pinctrl-sun5i-a10s.o
+obj-$(CONFIG_PINCTRL_SUN5I_A13)		+= pinctrl-sun5i-a13.o
+obj-$(CONFIG_PINCTRL_SUN6I_A31)		+= pinctrl-sun6i-a31.o
+obj-$(CONFIG_PINCTRL_SUN6I_A31_R)	+= pinctrl-sun6i-a31-r.o
+obj-$(CONFIG_PINCTRL_SUN7I_A20)		+= pinctrl-sun7i-a20.o
-- 
1.9.1
