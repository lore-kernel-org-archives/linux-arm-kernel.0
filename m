From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 1 Nov 2016 16:35:49 +0300
Subject: [PATCH v4 20/23] ARM: shmobile: rcar-gen2: Stop passing mode pins
 state to clock driver
In-Reply-To: <1477055857-17936-21-git-send-email-geert+renesas@glider.be>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
 <1477055857-17936-21-git-send-email-geert+renesas@glider.be>
Message-ID: <722d91fe-574a-8613-34ff-d44be19157be@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2016 04:17 PM, Geert Uytterhoeven wrote:

> Now the R-Car Gen2 CPG clock driver obtains the state of the mode pins
> from the R-Car RST driver, there's no longer a need to pass this state
> explicitly. Hence we can just call of_clk_init() instead.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
> v4:
>   - Add Acked-by,
>   - Rebase on top of "ARM: shmobile: rcar-gen2: Obtain extal frequency
>     from DT",
>   - Remove the call to rcar_gen2_read_mode_pins(),
>
> v3:
>   - Drop "select MFD_SYSCON", as the clock driver no longer uses syscon,
>
> v2:
>   - Kill compiler warning if CONFIG_ARM_ARCH_TIMER is not enabled.
> ---
>  arch/arm/mach-shmobile/setup-rcar-gen2.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> index afb9fdcd3d9084e2..b527258e0a62e806 100644
> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
[...]
> @@ -130,7 +129,7 @@ void __init rcar_gen2_timer_init(void)
>  	iounmap(base);
>  #endif /* CONFIG_ARM_ARCH_TIMER */
>
> -	rcar_gen2_clocks_init(mode);
> +	of_clk_init(NULL);
>  	clocksource_probe();
>  }
>

   This hunk no longer applies to devel.

MBR, Sergei
