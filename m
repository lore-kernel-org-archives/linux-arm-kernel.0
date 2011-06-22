From: balbi@ti.com (Felipe Balbi)
Date: Wed, 22 Jun 2011 17:32:17 +0300
Subject: [PATCH 1/2] gpio-vbus: support disabling D+ pullup on suspend
In-Reply-To: <Pine.LNX.4.44L0.1106221025270.1977-100000@iolanthe.rowland.org>
References: <20110622132314.GG23598@legolas.emea.dhcp.ti.com>
	<Pine.LNX.4.44L0.1106221025270.1977-100000@iolanthe.rowland.org>
Message-ID: <20110622143216.GE27654@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 22, 2011 at 10:30:18AM -0400, Alan Stern wrote:
> On Wed, 22 Jun 2011, Felipe Balbi wrote:
> 
> > Hi,
> > 
> > On Wed, Jun 22, 2011 at 04:20:16PM +0400, Dmitry Eremin-Solenikov wrote:
> > > Some platforms would like to disable D+ pullup on suspend, to drain as
> > > low power, as possible. E.g. this was requested by mioa701 board
> > > maintainers.
> > 
> > I think this makes sense to many platforms, but by doing so, you would
> > loose connection to the Host PC, so you need to make sure your device
> > isn't been used before you go down this road.
> 
> In fact, something like this is _necessary_ for all UDC/PHY drivers
> unless the device can guarantee that it will automatically wake up from
> suspend in time to service a USB packet (note that the window for
> responding to a packet is only a few microseconds).  Otherwise the
> device would appear to the host to be unresponsive and broken -- better
> to do a clean disconnect.
> 
> If suspending the device while it is in use would cause problems ...  
> then don't suspend it when it is in use!

I second your thoughts, but today we don't have enough infrastructure to
communicate between PHY and Link, so a clean solution isn't possible,
right ?

Should we block this patch due to that ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110622/555e71af/attachment.sig>
