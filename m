From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Fri, 16 Dec 2011 11:35:39 -0500
Subject: [PATCH V2 3/4] arm/imx6q: register arm_clk as cpu to clkdev
In-Reply-To: <1324031462-24961-4-git-send-email-richard.zhao@linaro.org>
References: <1324031462-24961-1-git-send-email-richard.zhao@linaro.org>,
 <1324031462-24961-4-git-send-email-richard.zhao@linaro.org>
Message-ID: <21672683C5A3814BB4DB938EBE482DE40A1AE8EF74@IAD2MBX09.mex02.mlsrvr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is there a portable/generic approach for other drivers that may
want to use arm-cpufreq.c? arm_clk is not normally defined for
my SoC and I don't see an easy way to pull it in.

--Mark Langsdorf
Calxeda, Inc.

________________________________________
From: Richard Zhao [richard.zhao at linaro.org]
Sent: Friday, December 16, 2011 4:31 AM
To: linux-arm-kernel at lists.infradead.org; cpufreq at vger.kernel.org; devicetree-discuss at lists.ozlabs.org
Cc: linux at arm.linux.org.uk; davej at redhat.com; kernel at pengutronix.de; shawn.guo at linaro.org; eric.miao at linaro.org; Mark Langsdorf; linaro-dev at lists.linaro.org; patches at linaro.org; Richard Zhao
Subject: [PATCH V2 3/4] arm/imx6q: register arm_clk as cpu to clkdev

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
+       _REGISTER_CLOCK(NULL, "cpu", arm_clk),
 };

 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
--
1.7.5.4
