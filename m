From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 22 Jul 2016 11:06:36 -0700
Subject: [PATCH -next] pinctrl: fix build, PINCTRL_CYGNUS_MUX depends on OF
Message-ID: <fbda11e7-273c-c91a-777d-5eaa61c86b82@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix pinctrl-cygnus-mux.c build when ARCH_BCM_CYGNUS is not enabled
but COMPILE_TEST is enabled by making the driver depend on OF.

../drivers/pinctrl/bcm/pinctrl-cygnus-mux.c:739:20: error: 'pinconf_generic_dt_node_to_map_group' undeclared here (not in a function)
  .dt_node_to_map = pinconf_generic_dt_node_to_map_group,

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ray Jui <rjui@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio at vger.kernel.org
---
 drivers/pinctrl/bcm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20160722.orig/drivers/pinctrl/bcm/Kconfig
+++ linux-next-20160722/drivers/pinctrl/bcm/Kconfig
@@ -60,6 +60,7 @@ config PINCTRL_IPROC_GPIO
 config PINCTRL_CYGNUS_MUX
 	bool "Broadcom Cygnus IOMUX driver"
 	depends on (ARCH_BCM_CYGNUS || COMPILE_TEST)
+	depends on OF
 	select PINMUX
 	select GENERIC_PINCONF
 	default ARCH_BCM_CYGNUS
