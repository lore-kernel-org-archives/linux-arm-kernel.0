From: heiko.stuebner@collabora.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 21 Dec 2015 22:22:28 +0100
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: enable rk808 clkout module
In-Reply-To: <2111669.2aeXLpXsWE@diego>
References: <2111669.2aeXLpXsWE@diego>
Message-ID: <6073058.AZlvB89lJp@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk808 supplies two clock outputs with one going back into the soc as
32kHz supply, supplying some core soc clocks with it. The system can boot
without it being present, but it is needed for example as source clock
for the thermal driver.

Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ff7eb19..2fa39c1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -662,6 +662,7 @@ CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC_CHARDEV=m
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_MAX77802=m
+CONFIG_COMMON_CLK_RK808=m
 CONFIG_COMMON_CLK_S2MPS11=m
 CONFIG_APQ_MMCC_8084=y
 CONFIG_MSM_GCC_8660=y
-- 
2.6.4
