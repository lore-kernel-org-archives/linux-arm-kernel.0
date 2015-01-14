From: balbi@ti.com (Felipe Balbi)
Date: Wed, 14 Jan 2015 12:39:43 -0600
Subject: [PATCH 08/12] usb: gadget: at91_udc: Remove non-DT handling code
In-Reply-To: <20150114183516.GN3843@piout.net>
References: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421252524-24452-9-git-send-email-alexandre.belloni@free-electrons.com>
 <20150114173812.GI16533@saruman> <20150114183516.GN3843@piout.net>
Message-ID: <20150114183943.GO16533@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 07:35:16PM +0100, Alexandre Belloni wrote:
> On 14/01/2015 at 11:38:12 -0600, Felipe Balbi wrote :
> > On Wed, Jan 14, 2015 at 05:22:00PM +0100, Alexandre Belloni wrote:
> > > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > 
> > > Since non-DT board support has been removed from the at91 architecture we
> > > can safely remove non-DT handling code.
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > ---
> > >  drivers/usb/gadget/udc/Kconfig    |  1 +
> > >  drivers/usb/gadget/udc/at91_udc.c | 16 ++--------------
> > >  2 files changed, 3 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> > > index b8e213eb36cc..366e551aeff0 100644
> > > --- a/drivers/usb/gadget/udc/Kconfig
> > > +++ b/drivers/usb/gadget/udc/Kconfig
> > > @@ -32,6 +32,7 @@ menu "USB Peripheral Controller"
> > >  config USB_AT91
> > >  	tristate "Atmel AT91 USB Device Port"
> > >  	depends on ARCH_AT91
> > > +	depends on OF || COMPILE_TEST
> > 
> > will this build with !OF builds ?
> > 
> 
> It should, I'll check but it doesn't matter because it depends on
> ARCH_AT91 which selects OF.

Missed that line :-)

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/50bd7b12/attachment.sig>
