From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Jul 2013 00:26:51 -0700
Subject: [PATCH] ARM: OMAP2+: twl-common: Remove code for twl6030 and
 twl6040 setup for legacy boot
In-Reply-To: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com>
References: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20130712072650.GC7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130711 07:30]:
> OMAP4 no longer boots in legacy mode so the code here is no longer used.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/twl-common.c | 332 ++-------------------------------------
>  arch/arm/mach-omap2/twl-common.h |   8 -
>  2 files changed, 12 insertions(+), 328 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index c05898f..932dea7 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -38,20 +38,6 @@ static struct i2c_board_info __initdata pmic_i2c_board_info = {
>  	.flags		= I2C_CLIENT_WAKE,
>  };
>  
> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> -static int twl_set_voltage(void *data, int target_uV)
> -{
> -	struct voltagedomain *voltdm = (struct voltagedomain *)data;
> -	return voltdm_scale(voltdm, target_uV);
> -}
> -
> -static int twl_get_voltage(void *data)
> -{
> -	struct voltagedomain *voltdm = (struct voltagedomain *)data;
> -	return voltdm_get_voltage(voltdm);
> -}
> -#endif

Looks like the code above is also needed for omap3 based on the
if defined?

Tony
