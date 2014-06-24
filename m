From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 24 Jun 2014 12:35:12 +0200
Subject: [PATCH v2 03/12] ARM: Berlin: select the reset controller
In-Reply-To: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1403606121-6368-4-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Berlin SoCs now has a reset controller. Add the needed
configuration.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 arch/arm/mach-berlin/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 2631cfc5ab0d..3a4fd1e41801 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -1,11 +1,13 @@
 menuconfig ARCH_BERLIN
 	bool "Marvell Berlin SoCs" if ARCH_MULTI_V7
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select GENERIC_IRQ_CHIP
 	select DW_APB_ICTL
 	select DW_APB_TIMER_OF
 	select PINCTRL
+	select RESET_CONTROLLER
 
 if ARCH_BERLIN
 
-- 
1.9.1
