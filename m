From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Oct 2016 11:59:13 +0200
Subject: [PATCH 4/5] ARM: defconfig: turn on the DT cpufreq for Integrator
In-Reply-To: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
References: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1476871154-32243-5-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrators are now migrated to handle the CPUfreq
scaling using the generic devicetree CPUfreq driver using the
common clock framework and have the required device tree
modifications, so turn off the old driver and turn on the new
generic driver.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/integrator_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 869faae67201..69cb8f1efcea 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -26,6 +26,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPUFREQ_DT=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
2.7.4
