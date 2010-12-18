From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Dec 2010 16:24:39 -0800
Subject: [PATCH 1/3] omap: rx51: Remove __initdata from rx51_tpa6130a2_data
In-Reply-To: <1292613505-10113-1-git-send-email-jhnikula@gmail.com>
References: <1292613505-10113-1-git-send-email-jhnikula@gmail.com>
Message-ID: <20101218002439.GA5941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jarkko Nikula <jhnikula@gmail.com> [101217 11:16]:
> If the TPA6130 is compiled as module the id and power_gpio values are
> arbitrary at module probing time since the rx51_tpa6130a2_data was marked as
> __initdata.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> For 2.6.38 as the TPA6130 is not used in 2.6.37.
> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index 126b724..cde6847 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -719,7 +719,7 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
>  	.vio			= &rx51_vio,
>  };
>  
> -static struct tpa6130a2_platform_data rx51_tpa6130a2_data __initdata = {
> +static struct tpa6130a2_platform_data rx51_tpa6130a2_data = {
>  	.id			= TPA6130A2,
>  	.power_gpio		= 98,
>  };

How about __initdata_or_module instead of __initdata?

Regards,

Tony
