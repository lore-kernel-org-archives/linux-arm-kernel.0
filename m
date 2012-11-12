From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 12 Nov 2012 19:19:47 +0100
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <50A1212C.2080601@wwwdotorg.org>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
 <1352650891-18356-2-git-send-email-andrew@lunn.ch>
 <50A020C5.4070506@wwwdotorg.org> <20121112082546.GU22029@lunn.ch>
 <50A1212C.2080601@wwwdotorg.org>
Message-ID: <20121112181947.GS24583@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 09:17:48AM -0700, Stephen Warren wrote:
> On 11/12/2012 01:25 AM, Andrew Lunn wrote:
> > On Sun, Nov 11, 2012 at 03:03:49PM -0700, Stephen Warren wrote:
> >> On 11/11/2012 09:21 AM, Andrew Lunn wrote:
> >>> From: Jamie Lentin <jm@lentin.co.uk>
> >>>
> >>> Given appropriate devicetree bindings, this driver registers a
> >>> pm_power_off function to set a GPIO line high/low to power down
> >>> your board.
> 
> >>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
> >>
> >>> +Required properties:
> >>> +- compatible : should be "gpio-poweroff".
> >>> +- gpios : The GPIO to set high/low, see "gpios property" in
> >>> +  Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be
> >>> +  low to power down the board set it to "Active Low", otherwise set
> >>> +  gpio to "Active High".
> >>
> >> Unfortunately, not all GPIO bindings support active high/low flags in
> >> the GPIO specifier. As such, the flags there are basically useless.
> >> Other bindings (e.g. IIRC the fixed-regulator binding) have added a
> >> separate active-high property to indicate the GPIO polarity. This
> >> binding should probably follow suite.
> > 
> > Humm, so are you saying of_get_named_gpio_flags() is deprecated?
> 
> I don't know if it's deprecated, but it's certainly not useful in
> generic code.

Hi Linus, Anton

How do you see this? 

I'm happy to implement an enable-active-high property, but it seems to
go against the purpose of of_get_named_gpio_flags(). Is that function
deprecated?

	Thanks
		Andrew
