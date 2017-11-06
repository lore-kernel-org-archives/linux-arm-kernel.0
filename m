From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Mon,  6 Nov 2017 12:38:13 +0530
Subject: [PATCH v2 1/4] arm64: defconfig: enable new trigger modes for leds
In-Reply-To: <cover.1509951550.git.amit.kucheria@linaro.org>
References: <cover.1509951550.git.amit.kucheria@linaro.org>
Message-ID: <266d889176a4f39617abbfb08177d4cbed89cdf2.1509951550.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most development boards and devices have one or more LEDs. It is useful
during debugging if they can be wired to show different behaviours such as
disk or cpu activity or a load-average dependent heartbeat. Enable panic
and disk activity triggers so they can be tied to LED activity during
debugging as well.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34480e9..4ed357f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -460,6 +460,8 @@ CONFIG_LEDS_SYSCON=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_LEDS_TRIGGER_PANIC=y
+CONFIG_LEDS_TRIGGER_DISK=y
 CONFIG_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX77686=y
-- 
2.7.4
