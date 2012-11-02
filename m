From: balbi@ti.com (Felipe Balbi)
Date: Fri, 2 Nov 2012 13:07:13 +0200
Subject: [PATCH 2/2] i2c: omap: use revision check for
 OMAP_I2C_FLAG_APPLY_ERRATA_I207
In-Reply-To: <1351852785-16961-3-git-send-email-shubhrajyoti@ti.com>
References: <1351852785-16961-1-git-send-email-shubhrajyoti@ti.com>
 <1351852785-16961-3-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121102110713.GC19493@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 02, 2012 at 04:09:45PM +0530, Shubhrajyoti D wrote:
> The errata i207 is enabled for 2430 and 3xxx. Use the revision check
> to enable the erratum instead.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

very good. I haven't read the errata but from a code standpoint, it
looks good:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/i2c/busses/i2c-omap.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d8e7709..44245d4 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1164,7 +1164,8 @@ omap_i2c_probe(struct platform_device *pdev)
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121102/78fc6173/attachment.sig>
