From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 17 Dec 2012 14:43:19 -0700
Subject: [PATCH 1/4] ARM: tegra30: Add support for Uart clock source
 divider as 15.1
In-Reply-To: <1355746101-15291-2-git-send-email-ldewangan@nvidia.com>
References: <1355746101-15291-1-git-send-email-ldewangan@nvidia.com>
 <1355746101-15291-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <50CF91F7.5010402@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 05:08 AM, Laxman Dewangan wrote:
> Tegra20 uart clock source have the 15.1 clock divider in place of

That says Tegra20, but ...

> 7.1. Add support for 15.1 clock divider and change the uart clock divider
> flag to DIV_U151.

>  arch/arm/mach-tegra/clock.h               |    3 +-
>  arch/arm/mach-tegra/tegra30_clocks.c      |   70 ++++++++++++++++++++++------
>  arch/arm/mach-tegra/tegra30_clocks_data.c |   10 ++--

... the patch only modifies Tegra30. Do both Tegra20 and Tegra30 have
this feature; should both clock drivers be updated?

BTW, Prashant is reworking the Tegra clock support to be modular, rather
than having a single monolithic "Tegra clock" type, and also moving the
code to drivers/clk. This patch will conflict signifcantly with that.
Please work with him to integrate this patch into his rework series,
either before or after his changes, and have him include the patch when
he posts his series. You'll also need to think about whether/how your
and his series depend on each-other.

... but: Is this a pure bug-fix? If so, I guess this patch should be
applied before Prashant's patches, and this patch also Cc: stable?
