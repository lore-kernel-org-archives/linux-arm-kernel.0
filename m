From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 08 Mar 2013 17:39:53 +0100
Subject: [PATCH 5/5] USB chipidea i.MX: use devm_usb_get_phy_by_phandle
 to get phy
In-Reply-To: <20130308163339.GG32368@arwen.pp.htv.fi>
References: <1362049024-11383-1-git-send-email-mkl@pengutronix.de>
 <1362049024-11383-6-git-send-email-mkl@pengutronix.de>
 <20130308163339.GG32368@arwen.pp.htv.fi>
Message-ID: <513A1459.6010000@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 05:33 PM, Felipe Balbi wrote:
> On Thu, Feb 28, 2013 at 11:57:04AM +0100, Marc Kleine-Budde wrote:
>> @@ -147,19 +146,20 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> -	phy_np = of_parse_phandle(pdev->dev.of_node, "fsl,usbphy", 0);
>> -	if (phy_np) {
>> -		data->phy_np = phy_np;
>> -		phy_pdev = of_find_device_by_node(phy_np);
>> -		if (phy_pdev) {
>> -			struct usb_phy *phy;
>> -			phy = pdev_to_phy(phy_pdev);
>> -			if (phy &&
>> -			    try_module_get(phy_pdev->dev.driver->owner)) {
>> -				usb_phy_init(phy);
>> -				data->phy = phy;
>> -			}
>> +	phy = devm_usb_get_phy_by_phandle(&pdev->dev, "fsl,usbphy", 0);
> 
> very nice, but should be done at chipidea core.

Any suggestions for the phandle name? "chipidea,usbphy"?

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130308/e9867bb3/attachment.sig>
