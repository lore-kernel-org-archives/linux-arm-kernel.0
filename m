From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 14 Feb 2013 13:15:28 -0700
Subject: [v2 1/4] ARM: tegra20: create a DT header defining CLK IDs
In-Reply-To: <1360868369-20093-2-git-send-email-hdoyu@nvidia.com>
References: <1360868369-20093-1-git-send-email-hdoyu@nvidia.com>
 <1360868369-20093-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <511D45E0.1080105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2013 11:59 AM, Hiroshi Doyu wrote:
> To replace magic number in tegra_car:
> 
> -               clocks = <&tegra_car 28>;
> +               clocks = <&tegra_car CLK_HOST1X>;

> diff --git a/arch/arm/boot/dts/tegra20-car.h b/arch/arm/boot/dts/tegra20-car.h

Sorry, forgot a couple small comments the last time around.

This file should probably have some header indicating which binding it
describes, rather like the GPIO header in my patch series.

> +#define CLK_CPU 0

I'd suggest naming that TEGRA20_CLK_CPU, so that the various different
clock headers don't conflict. It's not too likely that more than one of
the /Tegra/ clock headers will be included at once, but it doesn't seem
that unlikely that a board file could end up having a Tegra clock header
included plus various other clock headers for some other chip that has
some clock outputs.

Oh, and I don't think you updated e.g. nvidia,tegra20-car.txt to remove
the list of clocks.

BTW, I assume this patch includes the changes from my recent "clk:
tegra: fix driver to match DT binding" and anything else similar that's
in the most recent Tegra for-next?
