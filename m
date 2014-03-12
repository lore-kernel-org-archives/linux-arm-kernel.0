From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 12 Mar 2014 11:19:25 +0100
Subject: [PATCH v3][ 3/9] usb: chipidea: Use standard usb-phy property.
In-Reply-To: <1394618518-13803-3-git-send-email-denis@eukrea.com>
References: <1394618518-13803-1-git-send-email-denis@eukrea.com>
 <1394618518-13803-3-git-send-email-denis@eukrea.com>
Message-ID: <20140312111925.1d3f0c20@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Denis Carikli wrote:
> This converts the Chipidea usbmisc driver to
> use the standard usb-phy property.
> 
[...]
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index c00f772..9a74100 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -130,7 +130,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	data->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "fsl,usbphy", 0);
> +	data->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
>  	if (IS_ERR(data->phy)) {
>  		ret = PTR_ERR(data->phy);
>  		goto err_clk;
>
How about accepting the old property too and print a warning, that it is
deprecated, rather than breaking all existing DT blobs?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
