From: balbi@ti.com (Felipe Balbi)
Date: Mon, 26 Nov 2012 11:14:00 +0200
Subject: [PATCH] i2c: omap: Remove the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE
 flag
In-Reply-To: <1353921235-22408-1-git-send-email-shubhrajyoti@ti.com>
References: <1353921235-22408-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121126091400.GD15766@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 02:43:55PM +0530, Shubhrajyoti D wrote:
> The OMAP_I2C_FLAG_RESET_REGS_POSTIDLE is not used anymore
> in the i2c driver. Remove the flag.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> Has dependency on the below patch
> http://git.pengutronix.de/?p=wsa/linux.git;a=commitdiff;h=554c96744afd169886bd6fc2736fb0d9aaf634e8
> 
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    3 +--
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +--
>  drivers/i2c/busses/i2c-omap.c              |    3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 943222c4..3dd9e69 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -791,8 +791,7 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
>  /* I2C1 */
>  static struct omap_i2c_dev_attr i2c1_dev_attr = {
>  	.fifo_depth	= 8, /* bytes */
> -	.flags		= OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
> -			  OMAP_I2C_FLAG_BUS_SHIFT_2,
> +	.flags		= OMAP_I2C_FLAG_BUS_SHIFT_2,

if it's not used anymore, how about removing its definition too ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/87bc63d1/attachment.sig>
