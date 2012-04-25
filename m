From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 25 Apr 2012 00:17:13 +0000
Subject: [PATCH 08/11] MXS: Add imx-otg driver
In-Reply-To: <201204242258.54799.marex@denx.de>
References: <1335099567-21056-1-git-send-email-marex@denx.de>
 <201204241949.37938.marex@denx.de> <20120424204947.GZ3852@pengutronix.de>
 <201204242258.54799.marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B7A1DA@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> There is more to be confused about -- you don't get the host/device
> connection
> interrupt from the PHY, but you dig one of them from the EHCI host and
> the other
> from the EHCI host too -- which is pretty messed up already.
> 
> We can certainly use IRQF_SHARED to trap some of the interrupts in the
> PHY code,
> but that's still quite weird.
> 
Below need to be implemented at phy driver:
- struct usb_phy;
- phy's interrupt which is only used for handle wakeup issue,
PHY's interrupt line is NOT the same with controller's, so you don't
need to use IRQF_SHARED, and request the same irq with controller's.

Below need to be implemented at otg driver:
- struct usb_otg;
- manage PHY through PHY interfaces which are implemented at phy driver.
- OTG interrupt, it only handles ID/vbus interrupt.
- OTG switch routine, it handles host and device's add/remove operation due to
id/vbus change and some operation_mode defined at platform_data or DT in fture.


> > Sascha
> 
> Best regards,
> Marek Vasut
