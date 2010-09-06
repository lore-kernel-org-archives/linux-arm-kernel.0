From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Sep 2010 00:45:16 +0200
Subject: [PATCH 15/74] ST SPEAr: adding support for rtc
In-Reply-To: <d9930e7793964f07a2e0acf7f52b45306e308ddd.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<d9930e7793964f07a2e0acf7f52b45306e308ddd.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100906224516.GB8153@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:11 Mon 30 Aug     , Viresh KUMAR wrote:
> From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> 
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/mach-spear13xx/clock.c                |    2 +-
>  arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
>  arch/arm/mach-spear13xx/spear1300_evb.c        |    1 +
>  arch/arm/mach-spear13xx/spear13xx.c            |   19 +
>  arch/arm/mach-spear3xx/clock.c                 |    2 +-
>  arch/arm/mach-spear3xx/include/mach/generic.h  |    1 +
>  arch/arm/mach-spear3xx/spear300_evb.c          |    1 +
>  arch/arm/mach-spear3xx/spear310_evb.c          |    1 +
>  arch/arm/mach-spear3xx/spear320_evb.c          |    1 +
>  arch/arm/mach-spear3xx/spear3xx.c              |   19 +
>  arch/arm/mach-spear6xx/clock.c                 |    2 +-
>  arch/arm/mach-spear6xx/include/mach/generic.h  |    1 +
>  arch/arm/mach-spear6xx/spear600_evb.c          |    1 +
>  arch/arm/mach-spear6xx/spear6xx.c              |   19 +
>  drivers/rtc/Kconfig                            |    7 +
>  drivers/rtc/Makefile                           |    1 +
>  drivers/rtc/rtc-spear.c                        |  598 ++++++++++++++++++++++++
>  17 files changed, 674 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/rtc/rtc-spear.c
> 
> diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
> index cef3b13..cc692cc 100644
> --- a/arch/arm/mach-spear13xx/clock.c
> +++ b/arch/arm/mach-spear13xx/clock.c
> @@ -736,7 +736,7 @@ static struct clk_lookup spear_clk_lookups[] = {
>  	{.con_id = "osc3_25m_clk",	.clk = &osc3_25m_clk},
>  
>  	/* clock derived from 32 KHz osc clk */
> -	{.dev_id = "rtc",		.clk = &rtc_clk},
> +	{.dev_id = "rtc-spear",		.clk = &rtc_clk},
>  
>  	/* clock derived from 24/25 MHz osc1/osc3 clk */
>  	{.con_id = "pll1_clk",		.clk = &pll1_clk},
> diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
> index 41c1a53..dc80421 100644
> --- a/arch/arm/mach-spear13xx/include/mach/generic.h
> +++ b/arch/arm/mach-spear13xx/include/mach/generic.h
> @@ -30,6 +30,7 @@
>  
>  /* Add spear13xx family device structure declarations here */
>  extern struct amba_device uart_device;
> +extern struct platform_device rtc_device;
no need to export all theres platform devices

it will be better to export funtion as done on AT91

to register the device

as

spear_rtc_device_add();

and the sme for the other devices etc...

btw you do not respect the kernel coding style please check your patches

Best Regards,
J.
