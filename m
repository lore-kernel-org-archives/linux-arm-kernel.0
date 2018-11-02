From: olof@lixom.net (Olof Johansson)
Date: Thu,  1 Nov 2018 19:57:28 -0700
Subject: [PATCH] pinctrl: mediatek: Fix dependencies for EINT_MTK
Message-ID: <20181102025728.963-1-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following config-time warning:

WARNING: unmet direct dependencies detected for EINT_MTK
  Depends on [n]: PINCTRL [=y] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n]) && (PINCTRL_MTK [=n] || PINCTRL_MTK_MOORE [=n] || COMPILE_TEST [=n])
  Selected by [y]:
  - PINCTRL_MTK_PARIS [=y] && PINCTRL [=y] && OF [=y] && (ARCH_MEDIATEK [=y] || COMPILE_TEST [=n])

Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/pinctrl/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 9d142e1da567..50efc9cc8ee7 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -3,7 +3,7 @@ menu "MediaTek pinctrl drivers"
 
 config EINT_MTK
 	bool "MediaTek External Interrupt Support"
-	depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || COMPILE_TEST
+	depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || PINCTRL_MTK_PARIS || COMPILE_TEST
 	select GPIOLIB
 	select IRQ_DOMAIN
 
-- 
2.11.0
