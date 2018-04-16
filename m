From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Apr 2018 14:26:53 -0700
Subject: 4.16 OMAP serial transmit corruption?
In-Reply-To: <20180416154545.GA5671@atomide.com>
References: <20180416151732.GU16141@n2100.armlinux.org.uk>
 <20180416154545.GA5671@atomide.com>
Message-ID: <20180416212653.GC5671@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [180416 15:47]:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [180416 15:19]:
> > Hi,
> > 
> > I'm not entirely sure what's going on, but I see corrupted characters
> > with the serial console on the OMAP4430 SDP board.  During boot,
> > everything seems fine, the problem appears to be userspace output.
> > 
> > For example, if I edit a file, then quit vi:
> > 
> > :q??%??B??Z?root at omap-4430sdp:~#
> 
> I don't think I've seen that one. What I've seen few times is
> typing a key on the serial console echoing back the previous
> character typed while the new character won't get displayed
> until hitting keyboard again. Only rebooting the device seems
> to solve this. This is with 4430 ES2.3 revision.
> 
> I wonder if we're missing some parts of errata i202 handling
> in omap_8250_mdr1_errataset()?

Trying to see what we might be missing in 8250_omap compared
to omap-serial, your description sounds like it could be similar
issue compared to what got fixed for omap-serial earlier with
commit 0ba5f66836c9 ("tty: serial: OMAP: use a 1-byte RX FIFO
threshold in PIO mode").

> Also, I'm seeing an issue where the UARTs won't idle on init
> with 8250_omap driver if connected to the wl12xx bluetooth port
> unless I write some data to the port first. It does not seem
> to be related to the rts/cts lines being wired as I've tested
> muxing them out of the way.

I'll try to debug this one a bit.

Regards,

Tony
