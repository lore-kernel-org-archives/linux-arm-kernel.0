From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 20 Jun 2013 00:16:33 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCB2MiA2LzddIGRyaXZlcnM6IGJ1czogaW14LXdlaW06?=
 =?UTF-8?B?IEFkZCBzdXBwb3J0IGZvciBpLk1YMS8yMS8yNS8yNy8zMS8zNS81MC81MS81?=
 =?UTF-8?B?Mw==?=
In-Reply-To: <20130619200757.GC14308@pengutronix.de>
References: <1371671678-6345-1-git-send-email-shc_work@mail.ru>
 <1371671678-6345-6-git-send-email-shc_work@mail.ru>
 <20130619200757.GC14308@pengutronix.de>
Message-ID: <1371672993.387718746@f288.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Alexander,
> 
> Nice work!
> 
> On Wed, Jun 19, 2013 at 11:54:37PM +0400, Alexander Shiyan wrote:
> > - - fsl,weim-cs-timing:	The timing array, contains 6 timing values for the
> > + - fsl,weim-cs-timing:	The timing array, contains timing values for the
> >  			child node. We can get the CS index from the child
> > -			node's "reg" property. This property contains the values
> > -			for the registers EIM_CSnGCR1, EIM_CSnGCR2, EIM_CSnRCR1,
> > +			node's "reg" property. For example, if i.MX6Q CPU
> > +			is used, this property contains the values for the
> > +			registers EIM_CSnGCR1, EIM_CSnGCR2, EIM_CSnRCR1,
> >  			EIM_CSnRCR2, EIM_CSnWCR1, EIM_CSnWCR2 in this order.
> > +			For other i.MX CPUs count of register and register
> > +			names may be different.
> 
> I think here we should have a more precise description for each SoC.

OK.

> >  Example for an imx6q-sabreauto board, the NOR flash connected to the WEIM:
> >  
> > diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> > index 1f70e84..4faedc21 100644
> > --- a/drivers/bus/Kconfig
> > +++ b/drivers/bus/Kconfig
> > @@ -8,10 +8,10 @@ config IMX_WEIM
> >  	bool "Freescale EIM DRIVER"
> >  	depends on ARCH_MXC
> >  	help
> > -	  Driver for i.MX6 WEIM controller.
> > +	  Driver for i.MX WEIM controller.
> >  	  The WEIM(Wireless External Interface Module) works like a bus.
> >  	  You can attach many different devices on it, such as NOR, onenand.
> > -	  But now, we only support the Parallel NOR.
> > +	  But now, we only support the "of_physmap" driver.
> 
> This comment is wrong. In the early versions of this patch indeed only
> parallel NOR was supported, but now there is no limitation on the device
> type anymore.

I am do not think so. But I will not insist on his opinion.
I checked the operation only for physmap-flash and mtd-ram.

...
> >  static const struct of_device_id weim_id_table[] = {
> > +	/* i.MX1/21 */
> > +	{ .compatible = "fsl,imx1-weim", .data = &imx1_weim_devtype, },
> > +	/* i.MX25/27/31/35 */
> > +	{ .compatible = "fsl,imx25-weim", .data = &imx25_weim_devtype, },
> 
> We usually name the compatible name after the oldest i.MX supporting
> this IP, not after the lowest number. So this should be imx27, not
> imx25.

OK. Seems this fact also avoid [7/7] part. Is not it?

---
