From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Jun 2012 15:34:20 +0300
Subject: [PATCHv10 5/7] I2C: OMAP: Remove the definition of
 SYSS_RESETDONE_MASK
In-Reply-To: <1340622702-21622-6-git-send-email-shubhrajyoti@ti.com>
References: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
 <1340622702-21622-6-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120625123419.GD30463@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 25, 2012 at 04:41:40PM +0530, Shubhrajyoti D wrote:
> Remove the definition of SYSS_RESETDONE_MASK and use the
> one in omap_hwmod.h.
> 
> Also fixes the warning
>  CC      drivers/i2c/busses/i2c-omap.o
> drivers/i2c/busses/i2c-omap.c:163: warning: "SYSS_RESETDONE_MASK" redefined
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/i2c/busses/i2c-omap.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index f1109f4..8344ad030 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -159,9 +159,6 @@ enum {
>  #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
>  #endif
>  
> -/* OCP_SYSSTATUS bit definitions */
> -#define SYSS_RESETDONE_MASK		(1 << 0)
> -
>  /* OCP_SYSCONFIG bit definitions */
>  #define SYSC_CLOCKACTIVITY_MASK		(0x3 << 8)
>  #define SYSC_SIDLEMODE_MASK		(0x3 << 3)
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/84938d01/attachment-0001.sig>
