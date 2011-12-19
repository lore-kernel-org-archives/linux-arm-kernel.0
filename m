From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 19 Dec 2011 11:21:42 +0800
Subject: [PATCH V3 6/7] arm/imx6q: register arm_clk as cpu to clkdev
In-Reply-To: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
References: <1324264903-15395-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1324264903-15395-7-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpufreq needs cpu clock to change frequency.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-imx/clock-imx6q.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx6q.c b/arch/arm/mach-imx/clock-imx6q.c
index 039a7ab..72acbc2 100644
--- a/arch/arm/mach-imx/clock-imx6q.c
+++ b/arch/arm/mach-imx/clock-imx6q.c
@@ -1911,6 +1911,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "gpmi_io_clk", gpmi_io_clk),
 	_REGISTER_CLOCK(NULL, "usboh3_clk", usboh3_clk),
 	_REGISTER_CLOCK(NULL, "sata_clk", sata_clk),
+	_REGISTER_CLOCK(NULL, "cpu", arm_clk),
 };
 
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
-- 
1.7.5.4
