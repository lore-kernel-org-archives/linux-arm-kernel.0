From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 22 Feb 2012 16:17:16 +0100
Subject: [PATCH v3 05/10] arm/tegra: Provide clock for only one PWM controller
In-Reply-To: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1329923841-32017-6-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A subsequent patch will add a generic PWM API driver for the Tegra2 PWFM
controller, supporting all four PWM devices with a single PWM chip. The
device will be named tegra-pwm and only one clock needs to be provided.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
Changes in v3:
  - none

Changes in v2:
  - none

 arch/arm/mach-tegra/tegra2_clocks.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index 379f201..6eec82d 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -2245,10 +2245,7 @@ static struct clk_duplicate tegra_clk_duplicates[] = {
 	CLK_DUPLICATE("usbd", "tegra-otg", NULL),
 	CLK_DUPLICATE("hdmi", "tegradc.0", "hdmi"),
 	CLK_DUPLICATE("hdmi", "tegradc.1", "hdmi"),
-	CLK_DUPLICATE("pwm", "tegra_pwm.0", NULL),
-	CLK_DUPLICATE("pwm", "tegra_pwm.1", NULL),
-	CLK_DUPLICATE("pwm", "tegra_pwm.2", NULL),
-	CLK_DUPLICATE("pwm", "tegra_pwm.3", NULL),
+	CLK_DUPLICATE("pwm", "tegra-pwm", NULL),
 	CLK_DUPLICATE("host1x", "tegra_grhost", "host1x"),
 	CLK_DUPLICATE("2d", "tegra_grhost", "gr2d"),
 	CLK_DUPLICATE("3d", "tegra_grhost", "gr3d"),
-- 
1.7.9.1
