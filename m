From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 11 Sep 2012 23:54:41 +0200
Subject: [PATCHv7 18/23] i2c: omap: remove redundant status read
In-Reply-To: <1347356538-23835-19-git-send-email-shubhrajyoti@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <1347356538-23835-19-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120911215441.GC27031@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 03:12:13PM +0530, Shubhrajyoti D wrote:
> Remove the redundant read of the status register.

Commit message is just repeating the subject.
Why was the read there and why can it be removed now?

> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 5d4bad4..498a462 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -946,7 +946,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  				num_bytes = dev->buf_len;
>  
>  			ret = omap_i2c_transmit_data(dev, num_bytes, true);
> -			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
>  			if (ret < 0)
>  				goto out;
>  
> @@ -962,7 +961,6 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  				num_bytes = dev->threshold;
>  
>  			ret = omap_i2c_transmit_data(dev, num_bytes, false);
> -			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
>  			if (ret < 0)
>  				goto out;
>  
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120911/ef823e8b/attachment-0001.sig>
