From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Dec 2016 13:05:30 +0100
Subject: [PATCH 3/3] ARM: defconfig: pxa: cut MPU3050 input driver
In-Reply-To: <20161227120530.31190-1-linus.walleij@linaro.org>
References: <20161227120530.31190-1-linus.walleij@linaro.org>
Message-ID: <20161227120530.31190-4-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PXA defconfig compiles the legacy MPU3050 driver as a module,
but the device does not appear in device trees nor board files, so
remove this from the defconfig assuming it was a mistake to add it
in the first place.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/pxa_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index e4314b1227a3..ce4660c79c7a 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -334,7 +334,6 @@ CONFIG_TOUCHSCREEN_TOUCHIT213=m
 CONFIG_TOUCHSCREEN_PCAP=m
 CONFIG_TOUCHSCREEN_ST1232=m
 CONFIG_INPUT_MISC=y
-CONFIG_INPUT_MPU3050=m
 CONFIG_INPUT_AXP20X_PEK=m
 CONFIG_INPUT_UINPUT=m
 CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
-- 
2.9.3
