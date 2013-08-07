From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Aug 2013 11:38:40 -0600
Subject: [PATCH 1/6] clk: Tegra: Add CPU0 clock driver
In-Reply-To: <8d192a13cb7e088943da40689d62bc6353bd8604.1375886595.git.viresh.kumar@linaro.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
 <8d192a13cb7e088943da40689d62bc6353bd8604.1375886595.git.viresh.kumar@linaro.org>
Message-ID: <52028620.6000608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 08:46 AM, Viresh Kumar wrote:
> This patch adds CPU0's clk driver for Tegra. It will be used by the generic
> cpufreq-cpu0 driver to get/set cpu clk.
> 
> Most of the platform specific bits are picked from tegra-cpufreq.c.

Hmmm. I'm not sure if it makes sense to represent this as a clock
object; isn't this more of a virtual construct that manages the rate of
the clock, rather than an actual clock? The actual clock already exists
as "cpu".
