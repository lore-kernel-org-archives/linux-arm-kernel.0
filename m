From: thomas.langer@lantiq.com (thomas.langer at lantiq.com)
Date: Tue, 20 Aug 2013 15:04:44 +0000
Subject: [PATCH v5 1/8] usb: phy: omap-control: Get rid of platform data
In-Reply-To: <1377010577-19355-2-git-send-email-rogerq@ti.com>
References: <1377010577-19355-1-git-send-email-rogerq@ti.com>
 <1377010577-19355-2-git-send-email-rogerq@ti.com>
Message-ID: <593AEF6C47F46446852B067021A273D6D982D30B@MUCSE039.lantiq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Roger,

this will not work!

Roger Quadros wrote on?2013-08-20:

> -	struct omap_control_usb_platform_data *pdata =
> -			dev_get_platdata(&pdev->dev);
> +
> +	if (np) {
> +		of_property_read_u32(np, "ti,type", &control_usb->type);

here you are dereferencing control_usb

> +	} else {
> +		/* We only support DT boot */
> +		return -EINVAL;
> +	}
> 
>  	control_usb = devm_kzalloc(&pdev->dev, sizeof(*control_usb),
>  		GFP_KERNEL);

and here it is allocated!

Best Regards,
Thomas
