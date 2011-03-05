From: swarren@nvidia.com (Stephen Warren)
Date: Fri,  4 Mar 2011 22:42:32 -0700
Subject: [PATCH 5/5] ARM: tegra: Harmony: Set WM8903 gpio_base
In-Reply-To: <1299303752-7779-1-git-send-email-swarren@nvidia.com>
References: <1299303752-7779-1-git-send-email-swarren@nvidia.com>
Message-ID: <1299303752-7779-6-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the final patch to enable audio support on Harmony. It additionally
relies on the latest ASoC branch being merged in, which provides the header
defining the gpio_base field in the WM8903 platform data.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-harmony.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index d002d16..57dc6ef 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -87,6 +87,7 @@ static struct wm8903_platform_data harmony_wm8903_pdata = {
 	.irq_active_low = 0,
 	.micdet_cfg = 0,
 	.micdet_delay = 100,
+	.gpio_base = HARMONY_GPIO_WM8903(0),
 	.gpio_cfg = {
 		WM8903_GPIO_NO_CONFIG,
 		WM8903_GPIO_NO_CONFIG,
-- 
1.7.1
