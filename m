From: w-kwok2@ti.com (Kwok, WingMan)
Date: Thu, 12 Dec 2013 17:24:31 +0000
Subject: [PATCH v3 2/2] usb: phy: Add keystone usb phy driver
In-Reply-To: <52A685E5.9060604@ti.com>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
 <1386627424-373-3-git-send-email-w-kwok2@ti.com> <52A685E5.9060604@ti.com>
Message-ID: <230CBA6E4B6B6B418E8730AC28E6FC7E0415C603@DFLE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Quadros, Roger
> Sent: Monday, December 09, 2013 10:09 PM
> To: Kwok, WingMan; linux-usb at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; Shilimkar, Santosh; Balbi, Felipe;
> Greg Kroah-Hartman
> Subject: Re: [PATCH v3 2/2] usb: phy: Add keystone usb phy driver
> 
> On 12/10/2013 03:47 AM, WingMan Kwok wrote:
> > Add Keystone platform USB PHY driver support. Current main purpose of
> > this driver is to enable the PHY reference clock gate on the Keystone
> > SoC. Otherwise it is a nop PHY.
> >
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> > ---
> >  drivers/usb/phy/Kconfig        |   10 +++
> >  drivers/usb/phy/Makefile       |    1 +
> >  drivers/usb/phy/phy-keystone.c |  142
> > ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 153 insertions(+)
> >  create mode 100644 drivers/usb/phy/phy-keystone.c
> >
> > diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig index
> > 08e2f39..c6792f43 100644
> > --- a/drivers/usb/phy/Kconfig
> > +++ b/drivers/usb/phy/Kconfig
> > @@ -40,6 +40,16 @@ config ISP1301_OMAP
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called isp1301_omap.
> >
> > +config KEYSTONE_USB_PHY
> > +	tristate "Keystone USB PHY Driver"
> > +	depends on ARCH_KEYSTONE
> > +	select USB_PHY
> 
> NOP_USB_XCEIV selects USB_PHY so not necessary.
> 

Yes I have fixed it and updated patch which I'll post.
" config AM335X_PHY_USB" needs to be fixed as well.

Regards
WingMan
