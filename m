From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  9 Dec 2013 09:27:44 +0100
Subject: [PATCH] pinctrl: add dependency on OF for MSM driver
Message-ID: <1386577664-23877-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We had a compilation failure on x86_64 due to missing OF support
as this was an implicit dependency. Add an explicit dependency
on OF so we get rid of this build failure.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 06e057bb3376..138d114d61b8 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -205,6 +205,7 @@ config PINCTRL_IMX28
 
 config PINCTRL_MSM
 	bool
+	depends on OF
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
-- 
1.8.3.1
