From: axel.lin@ingics.com (Axel Lin)
Date: Wed, 28 Nov 2012 14:37:20 +0800
Subject: [PATCH RESEND] pinctrl: Drop selecting PINCONF for MMP2, PXA168 and
 PXA910
Message-ID: <1354084640.18972.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These drivers do not need to select PINCONF.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
This patch was sent on https://lkml.org/lkml/2012/11/12/12.
Resend to Haojian's correct email address.

 drivers/pinctrl/Kconfig |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index f06a073..c31aeb0 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -96,7 +96,6 @@ config PINCTRL_MMP2
 	bool "MMP2 pin controller driver"
 	depends on ARCH_MMP
 	select PINCTRL_PXA3xx
-	select PINCONF
 
 config PINCTRL_MXS
 	bool
@@ -133,13 +132,11 @@ config PINCTRL_PXA168
 	bool "PXA168 pin controller driver"
 	depends on ARCH_MMP
 	select PINCTRL_PXA3xx
-	select PINCONF
 
 config PINCTRL_PXA910
 	bool "PXA910 pin controller driver"
 	depends on ARCH_MMP
 	select PINCTRL_PXA3xx
-	select PINCONF
 
 config PINCTRL_SINGLE
 	tristate "One-register-per-pin type device tree based pinctrl driver"
-- 
1.7.9.5
