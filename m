From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 27 Mar 2011 01:52:45 +0100
Subject: [PATCH RFC] ARM: PXA27x: CPUFREQ: Don't use fastbus mode
In-Reply-To: <1301169103-23968-1-git-send-email-anarsoul@gmail.com>
References: <1301169103-23968-1-git-send-email-anarsoul@gmail.com>
Message-ID: <201103270152.45581.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 26 March 2011 20:51:43 Vasily Khoruzhick wrote:
> PXA27x does not like fastbus for some reason, it can hang in
> random places when it's enabled. So don't use it to make cpufreq
> stable.

This is B/S, you're loosing performance! I'd suggest module parameter or device-
specific callback to toggle use of fastbus on/off.

Cheers
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-pxa/cpufreq-pxa2xx.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> b/arch/arm/mach-pxa/cpufreq-pxa2xx.c index 6a7aeab..b5727aa 100644
> --- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> +++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
> @@ -156,13 +156,13 @@ MODULE_PARM_DESC(pxa255_turbo_table, "Selects the
> frequency table (0 = run table ((T)  ? CCLKCFG_TURBO : 0))
> 
>  static pxa_freqs_t pxa27x_freqs[] = {
> -	{104000, 104000, PXA27x_CCCR(1,	 8, 2), 0, CCLKCFG2(1, 0, 1),  900000,
> 1705000 }, -	{156000, 104000, PXA27x_CCCR(1,	 8, 3), 0, CCLKCFG2(1, 0, 1),
> 1000000, 1705000 }, +	{104000, 104000, PXA27x_CCCR(1,	 8, 2), 0,
> CCLKCFG2(0, 0, 1),  900000, 1705000 }, +	{156000, 104000, PXA27x_CCCR(1,	
> 8, 3), 0, CCLKCFG2(0, 0, 1), 1000000, 1705000 }, {208000, 208000,
> PXA27x_CCCR(0, 16, 2), 1, CCLKCFG2(0, 0, 1), 1180000, 1705000 },
> -	{312000, 208000, PXA27x_CCCR(1, 16, 3), 1, CCLKCFG2(1, 0, 1), 1250000,
> 1705000 }, -	{416000, 208000, PXA27x_CCCR(1, 16, 4), 1, CCLKCFG2(1, 0, 1),
> 1350000, 1705000 }, -	{520000, 208000, PXA27x_CCCR(1, 16, 5), 1,
> CCLKCFG2(1, 0, 1), 1450000, 1705000 }, -	{624000, 208000, PXA27x_CCCR(1,
> 16, 6), 1, CCLKCFG2(1, 0, 1), 1550000, 1705000 } +	{312000, 208000,
> PXA27x_CCCR(1, 16, 3), 1, CCLKCFG2(0, 0, 1), 1250000, 1705000 },
> +	{416000, 208000, PXA27x_CCCR(1, 16, 4), 1, CCLKCFG2(0, 0, 1), 1350000,
> 1705000 }, +	{520000, 208000, PXA27x_CCCR(1, 16, 5), 1, CCLKCFG2(0, 0, 1),
> 1450000, 1705000 }, +	{624000, 208000, PXA27x_CCCR(1, 16, 6), 1,
> CCLKCFG2(0, 0, 1), 1550000, 1705000 } };
> 
>  #define NUM_PXA27x_FREQS ARRAY_SIZE(pxa27x_freqs)
