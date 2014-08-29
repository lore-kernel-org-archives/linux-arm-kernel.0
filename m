From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Aug 2014 14:51:59 +0200
Subject: [PATCH] pinctrl: sh-pfc: use a saner Kconfig symbol
Message-ID: <1409316719-28904-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is currently a kludge to get the Makefile to move down
to sh-pfc:s drivers: the arch definitions are used twice to
get it done. However we can very well use the Kconfig symbol
for the SH PFC pin control feature itself: it doesn't matter
that it comes from a lower leaf in the Kconfig hierarchy which
is completely orthogonal.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 7ebb3c5a9c30..0ffe1f608c67 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -60,8 +60,7 @@ obj-$(CONFIG_PLAT_ORION)        += mvebu/
 obj-y				+= nomadik/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_PINCTRL_SAMSUNG)	+= samsung/
-obj-$(CONFIG_ARCH_SHMOBILE)	+= sh-pfc/
-obj-$(CONFIG_SUPERH)		+= sh-pfc/
+obj-$(CONFIG_PINCTRL_SH_PFC)	+= sh-pfc/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
-- 
1.9.3
