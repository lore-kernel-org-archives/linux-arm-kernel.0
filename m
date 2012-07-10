From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 10 Jul 2012 13:38:58 +0200
Subject: [PATCH v9 REBASE 6/9] USB: notify phy when root hub port connect
 change
In-Reply-To: <20120710112050.GH26888@b20223-02.ap.freescale.net>
References: <1341673008-29808-1-git-send-email-richard.zhao@freescale.com>
 <201207100522.21162.marex@denx.de>
 <20120710112050.GH26888@b20223-02.ap.freescale.net>
Message-ID: <201207101338.58340.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Richard Zhao,

[...]

> > > --- a/drivers/usb/core/hub.c
> > > +++ b/drivers/usb/core/hub.c
> > > @@ -1924,6 +1924,11 @@ void usb_disconnect(struct usb_device **pdev)
> > > 
> > >  	 */
> > >  	
> > >  	device_del(&udev->dev);
> > > 
> > > +	if (udev->parent && !udev->parent->parent) {
> > > +		struct usb_hcd *hcd = bus_to_hcd(udev->bus);
> > > +		usb_phy_notify_disconnect(hcd->phy, udev->portnum);
> > > +	}
> > 
> > Shouldn't that go before device_del() ?
> 
> Any difference?

I was worried some corruption of other members in udev structure might happen, 
but I'm not so sure anymore after taking deer look.

> Thanks
> Richard

Best regards,
Marek Vasut
