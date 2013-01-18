From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Fri, 18 Jan 2013 15:39:56 +0100
Subject: [PATCH 1/3] cpufreq: kirkwood: Add a cpufreq driver for Marvell
 Kirkwood SoCs
In-Reply-To: <1358518846-16251-2-git-send-email-andrew@lunn.ch> (Andrew Lunn's
 message of "Fri, 18 Jan 2013 15:20:44 +0100")
References: <1358518846-16251-1-git-send-email-andrew@lunn.ch>
 <1358518846-16251-2-git-send-email-andrew@lunn.ch>
Message-ID: <8738xyimgz.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Andrew" == Andrew Lunn <andrew@lunn.ch> writes:

 Andrew> The Marvell Kirkwood SoCs have simple cpufreq support in hardware. The
 Andrew> CPU can either use the a high speed cpu clock, or the slower DDR
 Andrew> clock. Add a driver to swap between these two clock sources.

 Andrew> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
 Andrew> ---
 Andrew>  drivers/clk/mvebu/clk-gating-ctrl.c |    1 +
 Andrew>  drivers/cpufreq/Kconfig.arm         |    6 +
 Andrew>  drivers/cpufreq/Makefile            |    1 +
 Andrew>  drivers/cpufreq/kirkwood-cpufreq.c  |  273 +++++++++++++++++++++++++++++++++++
 Andrew>  4 files changed, 281 insertions(+)
 Andrew>  create mode 100644 drivers/cpufreq/kirkwood-cpufreq.c

 Andrew> +++ b/drivers/cpufreq/Kconfig.arm
 Andrew> @@ -77,6 +77,12 @@ config ARM_EXYNOS5250_CPUFREQ
 Andrew>  	  This adds the CPUFreq driver for Samsung EXYNOS5250
 Andrew>  	  SoC.
 
 Andrew> +config ARM_KIRKWOOD_CPUFREQ
 Andrew> +        def_bool ARCH_KIRKWOOD && OF
 Andrew> +	help

The def_bool should be indented with a <tab>

Otherwise looks good.

-- 
Bye, Peter Korsgaard
