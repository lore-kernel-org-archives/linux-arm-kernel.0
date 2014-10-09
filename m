From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 09 Oct 2014 13:32:59 +0200
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: Enable clock and RTC driver for
 S2M and S5M
In-Reply-To: <1412854379-18875-1-git-send-email-k.kozlowski@samsung.com>
References: <1412854379-18875-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1412854379-18875-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The multi_v7 config already enables MFD and regulators drivers for
Samsung's S2MPS11/S2MPS14 and S5M8767. Enable also drivers for the rest
of these PMICs features: clock and RTC.

These PMICs are used on Arndale (Exynos 5250 and 5420) and Origen
(Exynos 4412) evaluation boards, Google Spring, Samsung Gear2 (Exynos
3250) and some other phones based on Exynos5.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3d37e9d2914f..1a60a69f26ad 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -391,6 +391,7 @@ CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_SUNXI=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_RTC_DRV_TEGRA=y
+CONFIG_RTC_DRV_S5M=y
 CONFIG_DMADEVICES=y
 CONFIG_DW_DMAC=y
 CONFIG_MV_XOR=y
@@ -414,6 +415,7 @@ CONFIG_NVEC_POWER=y
 CONFIG_NVEC_PAZ00=y
 CONFIG_QCOM_GSBI=y
 CONFIG_COMMON_CLK_QCOM=y
+CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
-- 
1.9.1
