From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 18 Apr 2014 20:07:23 +0200
Subject: [PATCH 1/4] ARM: Kirkwood: Add board file for netxbig LEDs
In-Reply-To: <20140418132148.GX28159@titan.lakedaemon.net>
References: <1397750938-25381-1-git-send-email-andrew@lunn.ch>
 <1397750938-25381-2-git-send-email-andrew@lunn.ch>
 <20140418132148.GX28159@titan.lakedaemon.net>
Message-ID: <20140418180723.GA32580@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 09:21:48AM -0400, Jason Cooper wrote:
> On Thu, Apr 17, 2014 at 06:08:55PM +0200, Andrew Lunn wrote:
> > There is currently no DT binding for the CPLD which controls the LEDs
> > on the Net 2Big and Net 5Big. So use a platform device.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  arch/arm/mach-mvebu/Kconfig         |   7 ++
> >  arch/arm/mach-mvebu/Makefile        |   1 +
> >  arch/arm/mach-mvebu/board-netxbig.c | 191 ++++++++++++++++++++++++++++++++++++
> 
> This seems pretty simple.  What's preventing this from becoming a
> full-fledged driver under drivers/leds?

It is. See drivers/leds/leds-netxbig.c

We can add a DT binding as the next step, in the same way that we are
converting T5325 audio by adding a binding to the codec. Simon also
said that they have an Intel platform also using the same driver, and
he would like to consider how that would work, DT, ACPI, etc. Once
Simon is back from vacation, we can figure out a binding.

	   Andrew
