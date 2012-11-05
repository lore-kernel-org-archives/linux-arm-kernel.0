From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Nov 2012 09:51:07 +0200
Subject: [PATCHv2 2/7] i2c: omap: use revision check for
 OMAP_I2C_FLAG_APPLY_ERRATA_I207
In-Reply-To: <1352025873-27492-3-git-send-email-shubhrajyoti@ti.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
 <1352025873-27492-3-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121105075107.GC32468@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 04, 2012 at 04:14:28PM +0530, Shubhrajyoti D wrote:
> The errata i207 is enabled for 2430 and 3xxx. Use the revision check
> to enable the erratum instead.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/i2c/busses/i2c-omap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 72fce6d..e009985 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1166,7 +1166,8 @@ omap_i2c_probe(struct platform_device *pdev)
>  
>  	dev->errata = 0;
>  
> -	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
> +	if (dev->rev >= OMAP_I2C_REV_ON_2430 &&
> +			dev->rev < OMAP_I2C_REV_ON_4430_PLUS)
>  		dev->errata |= I2C_OMAP_ERRATA_I207;
>  
>  	if (dev->rev <= OMAP_I2C_REV_ON_3430_3530)
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/5d75cd68/attachment.sig>
