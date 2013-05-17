From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 17 May 2013 16:54:49 -0600
Subject: [PATCH] clk: tegra: Use common of_clk_init() function
In-Reply-To: <1365066351-2395-1-git-send-email-pgaikwad@nvidia.com>
References: <1365066351-2395-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <5196B539.4040708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2013 03:05 AM, Prashant Gaikwad wrote:
> Use common of_clk_init() function for clocks initialization.

Prashant, can you please resend this to Mike for inclusion in 3.11; now
that we have moved the Tegra clock driver out of arch/arm/mach-tegra, we
should send all clock driver changes through Mike if possible. Thanks.

Just one question though:

> diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c

> -#include <linux/clk/tegra.h>
> +#include <linux/clk-provider.h>

Is clk-provider.h the right header? This code isn't a clock provider?
