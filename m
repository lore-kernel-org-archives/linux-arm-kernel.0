From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Aug 2016 19:21:19 +0100
Subject: [PATCH 1/2] usb: ohci-sa1111: remove machine_has_neponset()
In-Reply-To: <Pine.LNX.4.44L0.1608261419510.1794-100000@iolanthe.rowland.org>
References: <20160826180309.GW1041@n2100.armlinux.org.uk>
 <Pine.LNX.4.44L0.1608261419510.1794-100000@iolanthe.rowland.org>
Message-ID: <20160826182119.GX1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 02:20:50PM -0400, Alan Stern wrote:
> On Fri, 26 Aug 2016, Russell King - ARM Linux wrote:
> 
> > On Fri, Aug 26, 2016 at 01:18:25PM -0400, Alan Stern wrote:
> > > On Fri, 26 Aug 2016, Russell King wrote:
> > > 
> > > > The neponset is a daughter board for the Assabet platform, which has a
> > > > SA1111 chip on it.  If we're initialising the SA1111 OHCI, and we're
> > > > part of a neponset, the host platform must be an Assabet.
> > > > 
> > > > This allows us to eliminate machine_has_neponset() from this driver,
> > > > replacing it instead with machine_is_assabet(), and killing the
> > > > mach/assabet.h include.
> > > 
> > > Silly question: What happens when there's an SA1111 OHCI controller on
> > > an Assabet platform, but contained in something other than a neponset
> > > daughterboard?
> > 
> > It's possible that there is such a thing, but unlikely - and we have
> > no code in mainline to support such a configuration.
> 
> In that case you can add:
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> to this and the 2/2 patch.

Thanks!

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
