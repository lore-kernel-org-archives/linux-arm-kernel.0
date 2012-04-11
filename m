From: balbi@ti.com (Felipe Balbi)
Date: Wed, 11 Apr 2012 14:35:38 +0300
Subject: [PATCHv7 14/18] I2C: OMAP: Use SET_RUNTIME_PM_OPS
In-Reply-To: <1334142776-10583-15-git-send-email-shubhrajyoti@ti.com>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
 <1334142776-10583-15-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120411113537.GG12064@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 04:42:52PM +0530, Shubhrajyoti D wrote:
> Use SET_RUNTIME_PM_OPS macro to set runtime functions.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index dd65416..28de1d2 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1217,15 +1217,12 @@ static int omap_i2c_runtime_resume(struct device *dev)
>  
>  	return 0;
>  }
> +#endif
>  
>  static struct dev_pm_ops omap_i2c_pm_ops = {
> -	.runtime_suspend = omap_i2c_runtime_suspend,
> -	.runtime_resume = omap_i2c_runtime_resume,
> +	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
> +			   omap_i2c_runtime_resume, NULL)
>  };
> -#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
> -#else
> -#define OMAP_I2C_PM_OPS NULL
> -#endif

I think you should keep this define, otherwise the pm pointer will
always be valid.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120411/c44025e5/attachment.sig>
