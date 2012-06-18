From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 18 Jun 2012 17:22:57 +0200
Subject: [PATCHv8 10/13] I2C: OMAP: simplify num_bytes handling
In-Reply-To: <1340029828-20751-11-git-send-email-shubhrajyoti@ti.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
 <1340029828-20751-11-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120618152257.GA10768@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 08:00:25PM +0530, Shubhrajyoti D wrote:
> From: Felipe Balbi <balbi@ti.com>
> 
> trivial patch, no functional changes

Wrong. This patch does change some behaviour, are you aware of that?

So, please check if the side-effect is affectong the code and adapt the
commit message, if everything is okay.

> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Reviewed-by : Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index e24eb1f..080193a 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -844,8 +844,7 @@ complete:
>  							OMAP_I2C_BUFSTAT_REG)
>  							>> 8) & 0x3F;
>  			}
> -			while (num_bytes) {
> -				num_bytes--;
> +			while (num_bytes--) {
>  				w = omap_i2c_read_reg(dev, OMAP_I2C_DATA_REG);
>  				if (dev->buf_len) {
>  					*dev->buf++ = w;
> @@ -887,8 +886,7 @@ complete:
>  							OMAP_I2C_BUFSTAT_REG)
>  							& 0x3F;
>  			}
> -			while (num_bytes) {
> -				num_bytes--;
> +			while (num_bytes--) {
>  				w = 0;
>  				if (dev->buf_len) {
>  					w = *dev->buf++;
> -- 
> 1.7.5.4
> 

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120618/54cd854c/attachment.sig>
