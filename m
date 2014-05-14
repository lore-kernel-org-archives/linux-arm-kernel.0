From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 14 May 2014 16:08:30 +0200
Subject: [PATCH 1/1] usb: core: Kconfig: refine the description for
 CONFIG_USB_OTG
In-Reply-To: <dc4c63c13058468db8ad8ec4a22204e8@BN1PR03MB235.namprd03.prod.outlook.com>
References: <1399947567-18958-1-git-send-email-peter.chen@freescale.com>
 <20140513111144.GA29360@kroah.com>
 <20140513154647.GM1151@saruman.home>
 <dc4c63c13058468db8ad8ec4a22204e8@BN1PR03MB235.namprd03.prod.outlook.com>
Message-ID: <20140514140830.GA16307@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 06:24:51AM +0000, Peter Chen wrote:
>  
> > 
> > On Tue, May 13, 2014 at 01:11:44PM +0200, Greg KH wrote:
> > > On Tue, May 13, 2014 at 10:19:27AM +0800, Peter Chen wrote:
> > > > the user should only select it when the board supports HNP and SRP,
> > > > it should NOT be selected if the board only supports dual-role
> > > > switch through ID pin.
> > > >
> > > > There is a discussion for it:
> > > > http://marc.info/?l=linux-arm-kernel&m=139994896101516&w=2
> > > > http://marc.info/?l=linux-usb&m=139994881701504&w=2
> > > >
> > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > > ---
> > > >  drivers/usb/core/Kconfig |   12 +++++++-----
> > > >  1 files changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
> > > > index cb8e991..158048b 100644
> > > > --- a/drivers/usb/core/Kconfig
> > > > +++ b/drivers/usb/core/Kconfig
> > > > @@ -54,13 +54,15 @@ config USB_OTG
> > > >  	default n
> > > >  	help
> > > >  	  The most notable feature of USB OTG is support for a
> > > > -	  "Dual-Role" device, which can act as either a device
> > > > -	  or a host. The initial role is decided by the type of
> > > > -	  plug inserted and can be changed later when two dual
> > > > -	  role devices talk to each other.
> > > > +	  otg device, which can act as either a device or a host.
> > > > +	  The initial role is decided by the type of plug inserted
> > > > +	  and can be changed using HNP (Host Negotiation Protocol)
> > > > +	  later when two otg devices talk to each other.
> > > >
> > > >  	  Select this only if your board has Mini-AB/Micro-AB
> > > > -	  connector.
> > > > +	  connector and supports HNP and SRP (Session Request Protocol).
> > > > +	  If the board only supports dual-role switch through ID
> > > > +	  pin, this configuration should not be selected.
> > >
> > > That's really lame.  What happened to our "all modconfig should work"
> > > goal?  Why can't you dynamically detect that this is not a config that
> > > works and handle it?
> > >
> 
> If CONFIG_USB_OTG and CONFIG_USB_OTG_WHITELIST are set, most of usb devices
> will not work when connect to host for current code.
> 
> So, we need a feature flag for hcd and gadget, and set this OTG feature flag
> if the platform supports it (using dtb or platform data).

Sounds reasonable, and much nicer than just trying to point to a help
configuration file that no one will ever read :)

greg k-h
