From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Oct 2012 18:56:07 +0000
Subject: [PATCH 1/4] leds: leds-ns2: add device tree binding
In-Reply-To: <20121016135153.GE28384@kw.sim.vm.gnt>
References: <1350315295-14567-1-git-send-email-simon.guinot@sequanux.org>
 <201210161302.39302.arnd@arndb.de> <20121016135153.GE28384@kw.sim.vm.gnt>
Message-ID: <201210161856.07692.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 October 2012, Simon Guinot wrote:
> On Tue, Oct 16, 2012 at 01:02:39PM +0000, Arnd Bergmann wrote:
> > 
> > I'm not overly familiar with the LED subsystem, but isn't this something
> > that could be done with the generic gpio-led driver?
> 
> Basically, the leds-gpio driver allows to associate one pin to one LED.
> It is simple and efficient. The LED can be turned on or off. And using a
> platform callback (gpio_blink_set), some hardware timer blink can be
> enabled. A very few platforms are using this last callback.
> 
> On the ns2 (and other lacie machines), there is three different modes
> for the front blue LED: on, off and SATA activity blink. Three different
> pins are used to configure the LED. Definitively it is not compatible
> with the leds-gpio driver.

Ok, thanks for the explantion. I think your approach is fine then.

	Arnd
