From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 07 Jan 2013 10:41:57 -0700
Subject: [PATCH] ARM: tegra30: make the wait time of CPU power up to
 proportional to HZ
In-Reply-To: <1357527374-31055-1-git-send-email-josephl@nvidia.com>
References: <1357527374-31055-1-git-send-email-josephl@nvidia.com>
Message-ID: <50EB08E5.8080503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2013 07:56 PM, Joseph Lo wrote:
> It would rather to use the API of time_to_jiffies than a constant number
> of jiffies for the wait time of CPU power up.
> 
> Based on the work by:
> Sang-Hun Lee <sanlee@nvidia.com>

Applied to Tegra's for-3.9/soc branch.

> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c

> -		timeout = jiffies + 5*HZ;
> +		timeout = jiffies + msecs_to_jiffies(50);

I did just want to confirm though; I think that changes the timeout from
5 seconds to 50mS and similarly for the other change. I assume that was
intended? The code certainly seemed to work just fine with this change
when I tested it.
