From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 12 Mar 2014 14:36:31 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2M11bIDMvOV0gdXNiOiBjaGlwaWRlYTogVXNlIHN0YW5k?=
 =?UTF-8?B?YXJkIHVzYi1waHkgcHJvcGVydHku?=
In-Reply-To: <20140312111925.1d3f0c20@ipc1.ka-ro>
References: <1394618518-13803-1-git-send-email-denis@eukrea.com>
 <1394618518-13803-3-git-send-email-denis@eukrea.com>
 <20140312111925.1d3f0c20@ipc1.ka-ro>
Message-ID: <1394620591.168495980@f118.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?????, 12 ????? 2014, 11:19 +01:00 ?? Lothar Wa?mann <LW@KARO-electronics.de>:
> Hi,
> 
> Denis Carikli wrote:
> > This converts the Chipidea usbmisc driver to
> > use the standard usb-phy property.
> > 
> [...]
> > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> > index c00f772..9a74100 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> > @@ -130,7 +130,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > -	data->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "fsl,usbphy", 0);
> > +	data->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "usb-phy", 0);
> >  	if (IS_ERR(data->phy)) {
> >  		ret = PTR_ERR(data->phy);
> >  		goto err_clk;
> >
> How about accepting the old property too and print a warning, that it is
> deprecated, rather than breaking all existing DT blobs?

And this change should be reflected in the bindings documentation.

---
