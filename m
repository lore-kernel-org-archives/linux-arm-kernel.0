From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 18 Apr 2012 10:33:20 -0400
Subject: [patch 1/1] kirkwood: Add iconnect support
In-Reply-To: <871unlyze3.fsf@lebrac.rtp-net.org>
References: <20120418104002.GA15924@lunn.ch>
 <871unlyze3.fsf@lebrac.rtp-net.org>
Message-ID: <20120418143320.GM15711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 02:53:40PM +0200, Arnaud Patard wrote:
> Andrew Lunn <andrew@lunn.ch> writes:
> 
> Hi,
> 
> >> > + 
> >> > +#define ICONNECT_BLINK_HALF_PERIOD   100
> >> > +
> >> > +static int iconnect_blink_set(unsigned gpio, int state,
> >>
> >>__init ?
> >
> > Hi Jason
> >
> > It is correct without __init. This function will get called when you
> > play with /sys/class/leds/*/trigger.
> >
> > However, this is the second public instance of this function, it is
> > also in mach-orion5x/dns323-setup.c.
> 
> yeah, I know. I initially planned to send a patchset adding iconnect
> support and putting this function into something like gpio.c but I
> forgot about it when converting my first iconnect patch into DT. Any
> objection about sending a patch doing that once I manage to merge the
> iconnect support (and of course, in this case, feel free to remind me
> of it if I forget to do it ) ?

I'd prefer to have the fixes first, then base new stuff off of the fix.

thx,

Jason.
