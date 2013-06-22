From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 22 Jun 2013 15:09:02 +0200
Subject: [PATCH v3 10/18] pwm: samsung: Rename to pwm-samsung-legacy
In-Reply-To: <1371766383-29077-11-git-send-email-tomasz.figa@gmail.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
 <1371766383-29077-11-git-send-email-tomasz.figa@gmail.com>
Message-ID: <72206051.D6kXZYm5YD@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch renames the old pwm-samsung driver to pwm-samsung-legacy to
create place for the new, rewritten, DT- and multiplatform- aware
pwm-samsung driver that will be added in further patch.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pwm/Makefile                                | 2 +-
 drivers/pwm/{pwm-samsung.c => pwm-samsung-legacy.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/pwm/{pwm-samsung.c => pwm-samsung-legacy.c} (100%)

Changes since v2:
 - Used git format-patch -M to detect rename.
 - Corrected commit message.

diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 94ba21e..229a599 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_PUV3)		+= pwm-puv3.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
-obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
+obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung-legacy.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung-legacy.c
similarity index 100%
rename from drivers/pwm/pwm-samsung.c
rename to drivers/pwm/pwm-samsung-legacy.c
-- 
1.8.2.1
