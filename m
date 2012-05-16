From: marex@denx.de (Marek Vasut)
Date: Wed, 16 May 2012 15:37:21 +0200
Subject: [PATCH 5/8] MXS: Add USB PHY driver
In-Reply-To: <20120516103529.GC22251@nchen-desktop>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
 <1337070219-3630-6-git-send-email-marex@denx.de>
 <20120516103529.GC22251@nchen-desktop>
Message-ID: <201205161537.21382.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

> On Tue, May 15, 2012 at 10:23:36AM +0200, Marek Vasut wrote:
> > Add driver that controls the built-in USB PHY in the i.MX233/i.MX28. This
> > enables the PHY upon powerup and shuts it down on shutdown.
> 
> Please add i.mx6q .
> 
> > +config USB_MXS_PHY
> > +	tristate "Freescale i.MX28 USB PHY support"
> > +	select USB_OTG_UTILS
> > +	select USB_IMX_COMPOSITE
> 
> Seems you will not use imx_otg.c with chipidea framework.

Good catch :)

> 
> > + *
> > + * Freescale i.MX28 USB PHY driver.
> 
> use mxs

Now ... I think we have two waring opinions in here :)

> > + *
> > +
> > +	/* Enable FS/LS compatibility and wakeup IRQs. */
> > +	val = BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3 |
> > +		BM_USBPHY_CTRL_ENIRQWAKEUP;
> > +
> > +	/* Enable IRQ sources. */
> > +	val |= BM_USBPHY_CTRL_ENIDCHG_WKUP | BM_USBPHY_CTRL_ENDPDMCHG_WKUP |
> > +		BM_USBPHY_CTRL_ENVBUSCHG_WKUP;
> 
> Please forget wakeup function currently, as it will make things more
> complicated.
> 
> > +
> > +	writel(val, x->io_priv + HW_USBPHY_CTRL_SET);
> > +
> > +	return 0;
> > +}
> > +
> > +	/* Disable FS/LS compatibility and wakeup IRQs. */
> > +	val = BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3 |
> > +		BM_USBPHY_CTRL_ENIRQWAKEUP;
> > +
> > +	/* Disable IRQ sources. */
> > +	val |= BM_USBPHY_CTRL_ENIDCHG_WKUP | BM_USBPHY_CTRL_ENDPDMCHG_WKUP |
> > +		BM_USBPHY_CTRL_ENVBUSCHG_WKUP;
> > +
> 
> The same with above
> 
> > +
> > +MODULE_ALIAS("platform:mxs-usb-phy");
> > +MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
> > +MODULE_DESCRIPTION("Freescale i.MX28 USB PHY driver");
> 
> mxs
> 
> > +MODULE_LICENSE("GPL");

Best regards,
Marek Vasut
