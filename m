From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 9 Jan 2015 12:19:55 +0100
Subject: [PATCH 4/4] clk: tegra: Add support for the Tegra132 CAR IP block
In-Reply-To: <20141216203829.22980.64446.stgit@chromeos-P9X79>
References: <20141216203813.22980.2301.stgit@chromeos-P9X79>
 <20141216203829.22980.64446.stgit@chromeos-P9X79>
Message-ID: <20150109111954.GB16465@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 12:38:29PM -0800, Paul Walmsley wrote:
> From: Paul Walmsley <pwalmsley@nvidia.com>
> 
> Tegra132 CAR supports almost the same clocks as Tegra124 CAR. This
> patch mostly deals with the small differences.
> 
> Since Tegra132 contains many of the same PLL clock sources used on
> Tegra114 and Tegra124, enable them in drivers/clk/tegra/clk-pll.c when
> the kernel is configured to include Tegra132 support.
> 
> This patch is based on several patches from others:
> 
> 1. a  patch from Peter De Schrijver:
> 
> http://lkml.iu.edu/hypermail/linux/kernel/1407.1/06094.html
> 
> 2. a patch from Bill Huang ("clk: tegra: enable cclk_g at boot on
> Tegra132"), and
> 
> 3. a patch from Allen Martin ("clk: Enable tegra clock driver for
> tegra132").

Doesn't this technically require Signed-off-bys from each of the above,
then?

> diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
[...]
> +/**
> + * tegra124_132_clock_init_pre - clock initialization preamble for T124/T132
> + * @np: struct device_node * of the DT node for the SoC CAR IP block
> + *
> + * Register most of the clocks controlled by the CAR IP block, along
> + * with a few clocks controlled by the PMC IP block.  Everything in
> + * this function should be common to Tegra124 and Tegra132.  XXX The
> + * PMC clock initialization should probably be moved to PMC-specific
> + * driver code.  No return value.
> + */
> +static void __init tegra124_132_clock_init_pre(struct device_node *np)

I would've personally named this tegra124_clock_init_pre(). In the past
we've named these functions after the first chip that needed them and if
later chips remained compatible they would simply use the one from an
earlier chip. That's consistent with the naming of compatible strings
and doesn't require changes to the function names if yet another SoC
generation were to need the same functionality.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150109/168d5ed2/attachment.sig>
