From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 21 Nov 2012 13:20:23 +0000
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <CACxGe6tgNVH9zeafMRKXcRUZmQjQXrAy_QtvhxpTT74200Hnxg@mail.gmail.com>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
 <1352650891-18356-2-git-send-email-andrew@lunn.ch>
 <20121115180557.924713E197F@localhost>
 <alpine.DEB.2.00.1211151810050.25381@marmot.wormnet.eu>
 <CACxGe6tgNVH9zeafMRKXcRUZmQjQXrAy_QtvhxpTT74200Hnxg@mail.gmail.com>
Message-ID: <20121121132023.3DB5F3E0A01@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Nov 2012 18:21:20 +0000, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, Nov 15, 2012 at 6:11 PM, Jamie Lentin <jm@lentin.co.uk> wrote:
> > On Thu, 15 Nov 2012, Grant Likely wrote:
> >
> >> On Sun, 11 Nov 2012 17:21:29 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
> >>>
> >>> From: Jamie Lentin <jm@lentin.co.uk>
> >>>
> >>> Given appropriate devicetree bindings, this driver registers a
> >>> pm_power_off function to set a GPIO line high/low to power down
> >>> your board.
> >>>
> >>> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> >>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >>> ---
> >>>  .../devicetree/bindings/gpio/gpio-poweroff.txt     |   22 ++++
> >>>  drivers/gpio/Kconfig                               |   10 ++
> >>>  drivers/gpio/Makefile                              |    2 +
> >>>  drivers/gpio/gpio-poweroff.c                       |  129
> >>> ++++++++++++++++++++
> >>
> >>
> >> This isn't a gpio controller driver. Don't put it into drivers/gpio
> >
> >
> > There's a v2 which puts it in drivers/power/reset/gpio-poweroff.c
> 
> Okay, thanks.
> 
> g.

So... I just read the power sequence proposal patch series which is
remarkably like a superset of what is needed here. Does it make sense to
use a power sequence for doing generic power off instead of this
interface?

g.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
