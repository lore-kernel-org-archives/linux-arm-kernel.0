From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Feb 2015 15:14:04 +0000
Subject: [PATCH v3 8/8] ARM: STI: Ensure requested STi's SysCfg Controlled
 IRQs are enabled at boot
In-Reply-To: <1424272444-16230-1-git-send-email-lee.jones@linaro.org>
References: <1424272444-16230-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1424272444-16230-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is used to enable System Configuration Register controlled
External, CTI (Core Sight), PMU (Performance Management), and PL310 L2
Cache IRQs prior to use.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-sti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 8825bc9..5d8b3f8 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -1,6 +1,7 @@
 menuconfig ARCH_STI
 	bool "STMicroelectronics Consumer Electronics SOCs" if ARCH_MULTI_V7
 	select ARM_GIC
+	select ST_IRQCHIP
 	select ARM_GLOBAL_TIMER
 	select PINCTRL
 	select PINCTRL_ST
-- 
1.9.1
