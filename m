From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 23 Jun 2018 23:33:28 +0200
Subject: [PATCH] media: i2c: lm3560: add support for lm3559 chip
In-Reply-To: <20180506080607.GA24212@amd>
References: <20180506080607.GA24212@amd>
Message-ID: <20180623213328.GA19154@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2018-05-06 10:06:07, Pavel Machek wrote:
> 
> Add support for LM3559, as found in Motorola Droid 4 phone, for
> example. SW interface seems to be identical.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Ping?

Could this and media: i2c: lm3560: use conservative defaults be
applied for v4.19? This is not too complex...

								Pavel
								
> 
> diff --git a/drivers/media/i2c/lm3560.c b/drivers/media/i2c/lm3560.c
> index b600e03a..c4e5ed5 100644
> --- a/drivers/media/i2c/lm3560.c
> +++ b/drivers/media/i2c/lm3560.c
> @@ -1,6 +1,6 @@
>  /*
>   * drivers/media/i2c/lm3560.c
> - * General device driver for TI lm3560, FLASH LED Driver
> + * General device driver for TI lm3559, lm3560, FLASH LED Driver
>   *
>   * Copyright (C) 2013 Texas Instruments
>   *
> @@ -465,6 +479,7 @@ static int lm3560_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id lm3560_id_table[] = {
> +	{LM3559_NAME, 0},
>  	{LM3560_NAME, 0},
>  	{}
>  };
> diff --git a/include/media/i2c/lm3560.h b/include/media/i2c/lm3560.h
> index a5bd310..0e2b1c7 100644
> --- a/include/media/i2c/lm3560.h
> +++ b/include/media/i2c/lm3560.h
> @@ -22,6 +22,7 @@
>  
>  #include <media/v4l2-subdev.h>
>  
> +#define LM3559_NAME	"lm3559"
>  #define LM3560_NAME	"lm3560"
>  #define LM3560_I2C_ADDR	(0x53)
>  
> 



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180623/0e179ed3/attachment.sig>
