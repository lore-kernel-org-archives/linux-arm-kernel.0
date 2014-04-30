From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 30 Apr 2014 09:13:31 +0200
Subject: [PATCH 97/97] ARM: l2c: convert berlin to generic l2c
 initialisation
In-Reply-To: <E1WerJr-0001aG-Jk@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerJr-0001aG-Jk@rmk-PC.arm.linux.org.uk>
Message-ID: <5360A29B.8070203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 09:34 PM, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

FWIW,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Thanks for looking into this!

> ---
>  arch/arm/mach-berlin/berlin.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
> index 6709d2a6bec8..ac181c6797ee 100644
> --- a/arch/arm/mach-berlin/berlin.c
> +++ b/arch/arm/mach-berlin/berlin.c
> @@ -18,16 +18,6 @@
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach/arch.h>
>  
> -static void __init berlin_init_machine(void)
> -{
> -	/*
> -	 * with DT probing for L2CCs, berlin_init_machine can be removed.
> -	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
> -	 */
> -	l2x0_of_init(0x30c00000, 0xfeffffff);
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -
>  static const char * const berlin_dt_compat[] = {
>  	"marvell,berlin",
>  	NULL,
> @@ -35,5 +25,10 @@ static const char * const berlin_dt_compat[] = {
>  
>  DT_MACHINE_START(BERLIN_DT, "Marvell Berlin")
>  	.dt_compat	= berlin_dt_compat,
> -	.init_machine	= berlin_init_machine,
> +	/*
> +	 * with DT probing for L2CCs, berlin_init_machine can be removed.
> +	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
> +	 */
> +	.l2c_aux_val	= 0x30c00000,
> +	.l2c_aux_mask	= 0xfeffffff,
>  MACHINE_END
> 
