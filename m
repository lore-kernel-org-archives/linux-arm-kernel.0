From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 11 Feb 2015 17:15:24 +0100
Subject: [PATCH 03/11] ARM: berlin: select MFD_BERLIN_CTRL
In-Reply-To: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1423671332-24580-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1423671332-24580-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Berlin controller mfd driver is responsible to probe multiple
sub-devices in both the soc and system controller nodes. It currently
registers the pin controller and the reset controller.

Select it for all Berlin SoCs.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/mach-berlin/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 3e40a947f3ea..b6131b9889c1 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -6,6 +6,7 @@ menuconfig ARCH_BERLIN
 	select DW_APB_ICTL
 	select DW_APB_TIMER_OF
 	select GENERIC_IRQ_CHIP
+	select MFD_BERLIN_CTRL
 	select PINCTRL
 
 if ARCH_BERLIN
-- 
2.3.0
