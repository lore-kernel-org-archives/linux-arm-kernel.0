From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Sep 2011 16:06:58 +0900
Subject: [PATCH V3 1/7] video: s3c-fb: Add S5P64X0 specific
	s3c_fb_driverdata
In-Reply-To: <1311787878-16193-2-git-send-email-ajaykumar.rs@samsung.com>
References: <1311787878-16193-1-git-send-email-ajaykumar.rs@samsung.com>
	<1311787878-16193-2-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <000b01cc6d2c$bbdf1650$339d42f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ajay Kumar wrote:
> 
> This patch:
> Adds s3c_fb_driverdata for S5P64X0, which supports 3 windows.
> Also, register "s5p64x0-fb" type driver_data.
> Existing s3c_fb_driverdata definitions in s3c-fb.c
> supports 5 or 2 windows.
> 

Hi Ajay,

(Cc'ed Florian Tobias Schandina)

> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> acked-by: Jingoo Han <jg1.han@samsung.com>

Should be "Acked-by"...

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Florian,
This is required for supporting FB on Samsung S5P64X0 SoC.
If you're ok, please apply this into your tree...

And if you need original patch, let us know. Ajay will send again.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  drivers/video/s3c-fb.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 4aecf21..0fda252 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -1859,6 +1859,30 @@ static struct s3c_fb_driverdata s3c_fb_data_s3c2443
=
> {
>  	},
>  };
> 
> +static struct s3c_fb_driverdata s3c_fb_data_s5p64x0 = {
> +	.variant = {
> +		.nr_windows	= 3,
> +		.vidtcon	= VIDTCON0,
> +		.wincon		= WINCON(0),
> +		.winmap		= WINxMAP(0),
> +		.keycon		= WKEYCON,
> +		.osd		= VIDOSD_BASE,
> +		.osd_stride	= 16,
> +		.buf_start	= VIDW_BUF_START(0),
> +		.buf_size	= VIDW_BUF_SIZE(0),
> +		.buf_end	= VIDW_BUF_END(0),
> +
> +		.palette = {
> +			[0] = 0x2400,
> +			[1] = 0x2800,
> +			[2] = 0x2c00,
> +		},
> +	},
> +	.win[0] = &s3c_fb_data_s5p_wins[0],
> +	.win[1] = &s3c_fb_data_s5p_wins[1],
> +	.win[2] = &s3c_fb_data_s5p_wins[2],
> +};
> +
>  static struct platform_device_id s3c_fb_driver_ids[] = {
>  	{
>  		.name		= "s3c-fb",
> @@ -1872,6 +1896,9 @@ static struct platform_device_id s3c_fb_driver_ids[]
= {
>  	}, {
>  		.name		= "s3c2443-fb",
>  		.driver_data	= (unsigned long)&s3c_fb_data_s3c2443,
> +	}, {
> +		.name		= "s5p64x0-fb",
> +		.driver_data	= (unsigned long)&s3c_fb_data_s5p64x0,
>  	},
>  	{},
>  };
> --
> 1.7.0.4
