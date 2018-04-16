From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Apr 2018 00:01:52 +0100
Subject: 4.16 OMAP serial transmit corruption?
In-Reply-To: <20180416212653.GC5671@atomide.com>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
 <20180416154545.GA5671@atomide.com>
 <20180416212653.GC5671@atomide.com>
Message-ID: <20180416230152.GK10990@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 02:26:53PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [180416 15:47]:
> > * Russell King - ARM Linux <linux@armlinux.org.uk> [180416 15:19]:
> > > Hi,
> > > 
> > > I'm not entirely sure what's going on, but I see corrupted characters
> > > with the serial console on the OMAP4430 SDP board.  During boot,
> > > everything seems fine, the problem appears to be userspace output.
> > > 
> > > For example, if I edit a file, then quit vi:
> > > 
> > > :q??%??B??Z?root at omap-4430sdp:~#
> > 
> > I don't think I've seen that one. What I've seen few times is
> > typing a key on the serial console echoing back the previous
> > character typed while the new character won't get displayed
> > until hitting keyboard again. Only rebooting the device seems
> > to solve this. This is with 4430 ES2.3 revision.
> > 
> > I wonder if we're missing some parts of errata i202 handling
> > in omap_8250_mdr1_errataset()?
> 
> Trying to see what we might be missing in 8250_omap compared
> to omap-serial, your description sounds like it could be similar
> issue compared to what got fixed for omap-serial earlier with
> commit 0ba5f66836c9 ("tty: serial: OMAP: use a 1-byte RX FIFO
> threshold in PIO mode").

... except this is the transmit side, not the receive side.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
