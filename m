From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 18 Jun 2010 20:04:20 +0200
Subject: [PATCH 02/05] mfd: enable onkey on max8925
In-Reply-To: <AANLkTiko7PRpnVlgsOwVHi5EjvEnpfEtC44zUnDMuQxp@mail.gmail.com>
References: <AANLkTiko7PRpnVlgsOwVHi5EjvEnpfEtC44zUnDMuQxp@mail.gmail.com>
Message-ID: <20100618180419.GB3582@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Wed, May 19, 2010 at 02:57:17PM +0800, Haojian Zhuang wrote:
> @@ -596,6 +614,15 @@ int __devinit max8925_device_init(struct
> max8925_chip *chip,
>  		dev_err(chip->dev, "Failed to add rtc subdev\n");
>  		goto out;
>  	}
> +
> +	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
> +			      ARRAY_SIZE(onkey_devs),
> +			      &onkey_resources[0], 0);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to add onkey subdev\n");
> +		goto out;
I think you want goto out_dev here.
I fixed it up for you and applied this patch to my for-next tree.

Cheers,
Samuel.


> +	}
> +
>  	if (pdata && pdata->regulator[0]) {
>  		ret = mfd_add_devices(chip->dev, 0, &regulator_devs[0],
>  				      ARRAY_SIZE(regulator_devs),
> -- 
> 1.5.6.5

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
