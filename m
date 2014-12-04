From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Dec 2014 09:24:11 -0600
Subject: [PATCH] arm: omap2: rx51-peripherals: fix build warning
In-Reply-To: <1417033655-32332-1-git-send-email-balbi@ti.com>
References: <1417033655-32332-1-git-send-email-balbi@ti.com>
Message-ID: <20141204152411.GF18045@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 02:27:35PM -0600, Felipe Balbi wrote:
> commit 68a3c04 ([media] ARM: OMAP2: RX-51: update
> si4713 platform data) updated board-rx51-peripherals.c
> so that si4713 could be easily used on DT boot, but
> it ended up introducing a build warning whenever
> si4713 isn't enabled.
> 
> This patches fixes that warning:
> 
> arch/arm/mach-omap2/board-rx51-peripherals.c:1000:36: warning: \
> 	?rx51_si4713_platform_data? defined but not used [-Wunused-variable]
>  static struct si4713_platform_data rx51_si4713_platform_data = {
> 
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

a gentle reminder on this one.

> ---
>  arch/arm/mach-omap2/board-rx51-peripherals.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index d18a5cf..bda20c5 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -997,9 +997,11 @@ static struct aic3x_pdata rx51_aic3x_data2 = {
>  	.gpio_reset = 60,
>  };
>  
> +#if IS_ENABLED(CONFIG_I2C_SI4713) && IS_ENABLED(CONFIG_PLATFORM_SI4713)
>  static struct si4713_platform_data rx51_si4713_platform_data = {
>  	.is_platform_device = true
>  };
> +#endif
>  
>  static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
>  #if IS_ENABLED(CONFIG_I2C_SI4713) && IS_ENABLED(CONFIG_PLATFORM_SI4713)
> -- 
> 2.1.0.GIT
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/2085bc1e/attachment.sig>
