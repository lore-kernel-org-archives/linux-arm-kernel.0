From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon,  5 Jun 2017 20:13:54 +0200
Subject: [PATCH] ARM64: Kconfig: Fix the missing hi655x common clk
In-Reply-To: <CALAqxLVn9r9R-wnrZbrFqYfwqZD-tegbJrZLsUeBjjBc4_Q89w@mail.gmail.com>
References: <CALAqxLVn9r9R-wnrZbrFqYfwqZD-tegbJrZLsUeBjjBc4_Q89w@mail.gmail.com>
Message-ID: <1496686434-13181-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the addition of the hi655x common clock, the config option is missing
for the ARM64's hi6220 platform. That leads to a non functionnal WiFi because
the hi655x clock driver misses when initializing the power sequence via DT.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 73272f4..6dfe72c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -79,6 +79,7 @@ config ARCH_LG1K
 config ARCH_HISI
 	bool "Hisilicon SoC Family"
 	select ARM_TIMER_SP804
+	select COMMON_CLK_HI655X
 	select HISILICON_IRQ_MBIGEN if PCI
 	select PINCTRL
 	help
-- 
2.7.4
