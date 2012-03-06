From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Mar 2012 14:45:23 -0500 (EST)
Subject: [RFC 00/14] Generic clk for Orion platforms.
In-Reply-To: <20120306172341.GU5050@titan.lakedaemon.net>
References: <1331015471-28872-1-git-send-email-andrew@lunn.ch>
 <20120306155840.GS5050@titan.lakedaemon.net> <20120306161743.GI24858@lunn.ch>
 <20120306172341.GU5050@titan.lakedaemon.net>
Message-ID: <alpine.LFD.2.02.1203061439190.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Mar 2012, Jason wrote:
> On Tue, Mar 06, 2012 at 05:17:43PM +0100, Andrew Lunn wrote:
> > On Tue, Mar 06, 2012 at 10:58:40AM -0500, Jason wrote:
> > > I'm assuming the driver(s) will increment a reference, so when it
> > > reaches zero, the framework would call a clk_gate hook.
> > 
> > You missed an important point. No driver has claimed these, but u-boot
> > has turned them on.
> 
> This sounds like a bug in u-boot.
> 
> > So we want linux to turn off all clocks for which
> > there is no driver using them, in order to save power.
> > kirkwood_clk_ctrl is dual purpose. It turns on needed clocks, but it
> > also turns off unneeded clocks.
> 
> This is creating a lot of complexity where the real answer seems to be
> to get u-boot to shutoff all peripheral clocks before handing over
> control to linux.

No.

Yes, u-Boot might be wrong.  But the kernel should always distrust as 
much as possible from the bootloader.  Instead of presuming some initial 
state from the bootloader, it is best to simply set that state up front.

The fewer ties you have with any bootloaders, the fewer bugs you'll have 
in the end.  Otherwise you might enter into a game of requiring a 
specific version of a specific bootloader to go with a given kernel, and 
that is far more complex to deal with than the complexity you are 
referring to above.


Nicolas
