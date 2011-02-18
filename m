From: konkers@google.com (Erik Gilling)
Date: Fri, 18 Feb 2011 15:45:35 -0800
Subject: [PATCH 1/3] ARM: Tegra: Add pll_d table entries for 252MHz
In-Reply-To: <1298071093-23865-2-git-send-email-swarren@nvidia.com>
References: <1298071093-23865-1-git-send-email-swarren@nvidia.com>
	<1298071093-23865-2-git-send-email-swarren@nvidia.com>
Message-ID: <AANLkTimp==gtU2jvCYExqoV6tv-_dgvsF0yAf_k-F7CX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These look good.  Have you run these through a CTS tester at 720x480
and 1280x720?  We pass those now and I want to make sure there's not
regressions.  We're supposed to be getting one in a week or two.  If
you haven't run it by then, I'll run a pass with these then merge.

Cheers,
   Erik

On Fri, Feb 18, 2011 at 3:18 PM, Stephen Warren <swarren@nvidia.com> wrote:
> This rate is required for correct generation of 640x480 HDMI video;
> see subsequent patches.
>
> Note: I tested the entry with 12MHz input. The other entries are untested,
> but appear logically correct. However, I'm not familiar enough with PLLs
> to know if they perhaps exceed the PLL VCO frequency, nor whether the
> cpcon values are strictly correct.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> ?arch/arm/mach-tegra/tegra2_clocks.c | ? ?5 +++++
> ?1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
> index 41f5953..f3ead19 100644
> --- a/arch/arm/mach-tegra/tegra2_clocks.c
> +++ b/arch/arm/mach-tegra/tegra2_clocks.c
> @@ -1531,6 +1531,11 @@ static struct clk_pll_freq_table tegra_pll_d_freq_table[] = {
> ? ? ? ?{ 19200000, 216000000, 135, 12, 1, 3},
> ? ? ? ?{ 26000000, 216000000, 216, 26, 1, 4},
>
> + ? ? ? { 12000000, 252000000, 252, 12, 1, 4},
> + ? ? ? { 13000000, 252000000, 252, 13, 1, 4},
> + ? ? ? { 19200000, 252000000, 210, 16, 1, 3},
> + ? ? ? { 26000000, 252000000, 252, 26, 1, 4},
> +
> ? ? ? ?{ 12000000, 594000000, 594, 12, 1, 8},
> ? ? ? ?{ 13000000, 594000000, 594, 13, 1, 8},
> ? ? ? ?{ 19200000, 594000000, 495, 16, 1, 8},
> --
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
