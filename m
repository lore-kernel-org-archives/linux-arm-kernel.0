From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Feb 2013 16:43:53 -0700
Subject: [PATCHv2] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <1362007694-3419-1-git-send-email-sboyd@codeaurora.org>
References: <1362007694-3419-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <512E9A39.3070207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2013 04:28 PM, Stephen Boyd wrote:
> The TWD and SCU configs are selected by default as long as
> MSM_SCORPIONMP is false and/or MCT is false. Implementing the
> logic this way certainly saves lines in the Kconfig but it
> precludes those machines which select MSM_SCORPIONMP or MCT from
> participating in the single zImage effort because when those
> machines are combined with other SMP capable machines the TWD and
> SCU are no longer selected by default.
> 
> Push the select out to the machine entries so that we can compile
> these machines together and still select the appropriate configs.

> Resending to collect some more acks.

Seems simple enough it doesn't really need many, but for Tegra,
Acked-by: Stephen Warren <swarren@nvidia.com>

Which kernel is this going into? It's possible Tegra will get converted
to multi-platform in 3.10, which might move that main ARCH_TEGRA block
from arch/arm/Kconfig into arch/arm/mach-tegra/Kconfig, although I
suppose it doesn't /have/ to move it. I think some/all(?) other
multi-platform conversions have moved their main Kconfig option like
that though.
