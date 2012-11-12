From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 12 Nov 2012 07:07:40 +0100
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <20121112011258.GA23724@lizard>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
 <1352650891-18356-2-git-send-email-andrew@lunn.ch>
 <CACRpkdZvHBjFQTrQnxvc3WCOb2CqGbjYJxyQ5qQkSbU+UWHYZA@mail.gmail.com>
 <20121112011258.GA23724@lizard>
Message-ID: <20121112060740.GR24583@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 11, 2012 at 05:12:58PM -0800, Anton Vorontsov wrote:
> On Mon, Nov 12, 2012 at 02:00:31AM +0100, Linus Walleij wrote:
> > On Sun, Nov 11, 2012 at 5:21 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > 
> > > From: Jamie Lentin <jm@lentin.co.uk>
> > >
> > > Given appropriate devicetree bindings, this driver registers a
> > > pm_power_off function to set a GPIO line high/low to power down
> > > your board.
> > >
> > > Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > So this is just a GPIO client like any such thing right?
> > 
> > I mean this thing has nothing more to do with the GPIO subsystem
> > than say, drivers/input/keyboard/gpio_keys.c?
> > 
> > So from the GPIO subsystem point of view controlling power is
> > an alien concept.
> > 
> > But I suspect Anton may be ready to welcome a driver like this
> > under drivers/power/* which I think is where it belongs.
> 
> Yup. driver/power/reset/ seems appropriate.

Hi Anton

I was unsure where to put it. I will submit new patches with the move.

I'm not too sure about 'reset' though. Its not a reset operation, the
power goes off and stays off. Would 'shutdown' or 'power_off' be
better?

  Andrew
