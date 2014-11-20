From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 10:04:34 +0100
Subject: [GIT PULL] Third Round of Renesas ARM Based Soc Updates for v3.19
In-Reply-To: <CAMuHMdWGnx9D4BJR3C0b=iuEKP_AN+JORiOHX+c-MkqcURAjtg@mail.gmail.com>
References: <cover.1415841454.git.horms+renesas@verge.net.au>
 <201411192216.27740.arnd@arndb.de>
 <CAMuHMdWGnx9D4BJR3C0b=iuEKP_AN+JORiOHX+c-MkqcURAjtg@mail.gmail.com>
Message-ID: <3299155.X2xrgWZ6OL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 08:56:10 Geert Uytterhoeven wrote:
> > Please have a look at drivers/power/restart for how other platforms do
> > this. You probably need to add a device node for whatever IP block
> > holds the reset register and then have a driver. What exactly this
> > driver should look like depends of course on what other registers are
> > part of this block.
> 
> I agree. Thanks for reminding us.
> 
> The IP block is the system-controller, which is also used for PM domain
> control. So I'll take care of it.

Is it just the pm-domain driver and the system reset that needs to 
access this block? If yes, then the best option would be to register
the reset handler from the pm-domain driver, otherwise I think you
should have a syscon device node that gets shared between all drivers
using this device.

	Arnd
