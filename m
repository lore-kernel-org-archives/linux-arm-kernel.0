From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Wed, 27 Aug 2014 15:18:09 +0530
Subject: [PATCH 06/14] pinctrl: samsung: use CONFIG_PINCTRL_SAMSUNG symbol in
 makefile
In-Reply-To: <1409132889-2080-1-git-send-email-ch.naveen@samsung.com>
References: <1409132889-2080-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1409132889-2080-6-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung Exynos7 is a ARM64bit processor. Which does not select
the CONFIG_PLAT_SAMSUNG symbol. CONFIG_PINCTRL_SAMSUNG is being
selected for both PLAT_SAMSUNG and ARCH_EXYNOS7 symbols.

This patch modifes the pinctrl/Makefile to use
CONFIG_PINCTRL_SAMSUNG symbol to compile the pinctrl/samsung/*.c

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: linus.walleij at linaro.org
Cc: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/pinctrl/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 05d2275..801777e 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -58,7 +58,7 @@ obj-$(CONFIG_ARCH_BERLIN)	+= berlin/
 obj-$(CONFIG_PLAT_ORION)        += mvebu/
 obj-y				+= nomadik/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
-obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
+obj-$(CONFIG_PINCTRL_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SHMOBILE)	+= sh-pfc/
 obj-$(CONFIG_SUPERH)		+= sh-pfc/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
-- 
1.7.9.5
