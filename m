From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Tue, 16 Dec 2014 17:08:21 +0530
Subject: [PATCH 1/2] ARM: omap5/dra7xx: Fix frequency typos.
In-Reply-To: <5f7d841d41f6485022e07a22c332d3c8ea985bfa.1418421100.git.lsorense@csclub.uwaterloo.ca>
References: <cover.1418421100.git.lsorense@csclub.uwaterloo.ca>
 <5f7d841d41f6485022e07a22c332d3c8ea985bfa.1418421100.git.lsorense@csclub.uwaterloo.ca>
Message-ID: <549019AD.9050807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Len,
On Saturday 13 December 2014 03:38 AM, Lennart Sorensen wrote:
> The switch statement of the possible list of SYSCLK1 frequencies is
> missing a 0 in 4 out of the 7 frequencies.
Indeed a good catch !!
Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
> 
> Signed-off-by: Len Sorensen <lsorense@csclub.uwaterloo.ca>
> ---
>  arch/arm/mach-omap2/timer.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 4f61148..fb0cb2b 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -513,11 +513,11 @@ static void __init realtime_counter_init(void)
>  	rate = clk_get_rate(sys_clk);
>  	/* Numerator/denumerator values refer TRM Realtime Counter section */
>  	switch (rate) {
> -	case 1200000:
> +	case 12000000:
>  		num = 64;
>  		den = 125;
>  		break;
> -	case 1300000:
> +	case 13000000:
>  		num = 768;
>  		den = 1625;
>  		break;
> @@ -529,11 +529,11 @@ static void __init realtime_counter_init(void)
>  		num = 192;
>  		den = 625;
>  		break;
> -	case 2600000:
> +	case 26000000:
>  		num = 384;
>  		den = 1625;
>  		break;
> -	case 2700000:
> +	case 27000000:
>  		num = 256;
>  		den = 1125;
>  		break;
> 
