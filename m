From: sw.youn@samsung.com (Seungwhan Youn)
Date: Mon,  4 Oct 2010 20:57:48 +0900
Subject: [PATCH 6/10] ARM: S5PV210: Add audio clocks as sysclk
In-Reply-To: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
References: <1286191550-22197-1-git-send-email-sw.youn@samsung.com>
Message-ID: <1286193468-18510-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds audio clocks(SCLK_AUDIO{0,1,2} and SCLK_AUDIO) to be
initial as a sysclk on boot-time.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 195a088..3f3b7ba 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -997,6 +997,10 @@ static struct clksrc_clk *sysclks[] = {
 	&clk_sclk_dac,
 	&clk_sclk_pixel,
 	&clk_sclk_hdmi,
+	&clk_sclk_audio0,
+	&clk_sclk_audio1,
+	&clk_sclk_audio2,
+	&clk_sclk_spdif,
 };
 
 void __init_or_cpufreq s5pv210_setup_clocks(void)
-- 
1.6.2.5
