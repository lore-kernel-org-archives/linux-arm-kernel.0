From: balbi@ti.com (Felipe Balbi)
Date: Fri, 8 Mar 2013 18:30:50 +0200
Subject: [PATCH 1/5] USB chipidea: ci13xxx-imx: create dynamic platformdata
In-Reply-To: <1362049024-11383-2-git-send-email-mkl@pengutronix.de>
References: <1362049024-11383-1-git-send-email-mkl@pengutronix.de>
 <1362049024-11383-2-git-send-email-mkl@pengutronix.de>
Message-ID: <20130308163050.GE32368@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

Hi,

On Thu, Feb 28, 2013 at 11:57:00AM +0100, Marc Kleine-Budde wrote:
> @@ -107,6 +100,18 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
>  		&& !usbmisc_ops)
>  		return -EPROBE_DEFER;
>  
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);

this isn't necessary. Look at how platform_device_add_data() is
implemented. It will duplicate whatever you pass to it. Which means you
can change ci13xxx_imx_platdata as much as you want ;-)

> @@ -168,7 +173,7 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
>  		reg_vbus = NULL;
>  	}
>  
> -	ci13xxx_imx_platdata.phy = data->phy;
> +	pdata->phy = data->phy;

it would be pretty cool to start seeing patches teaching chipidea core
how to handle its own resources (regulators, phys, clocks, etc).

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130308/2ebaec4f/attachment.sig>
