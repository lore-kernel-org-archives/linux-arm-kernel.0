From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 17 Nov 2014 14:33:12 +0100
Subject: [PATCH 2/2] ARM: berlin: do not select RESET_CONTROLLER
In-Reply-To: <1416231192-27056-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1416231192-27056-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1416231192-27056-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RESET_CONTROLLER is meant to be user-selectable. To respect that,
do not select it automatically when using ARCH_BERLIN.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/mach-berlin/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 5803f773a065..51582c73a53f 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -7,7 +7,6 @@ menuconfig ARCH_BERLIN
 	select DW_APB_ICTL
 	select DW_APB_TIMER_OF
 	select PINCTRL
-	select RESET_CONTROLLER
 
 if ARCH_BERLIN
 
-- 
2.1.0
