From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 12 Feb 2013 21:26:34 +1300
Subject: Devicetree node to turn off LCD when backlight is 'disabled'
In-Reply-To: <20130212070418.GC28850@avionic-0098.mockup.avionic-design.de>
References: <1360563905.4130.6.camel@gitbox>
 <20130212070418.GC28850@avionic-0098.mockup.avionic-design.de>
Message-ID: <1360657594.3878.4.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-02-12 at 08:04 +0100, Thierry Reding wrote:
> On Mon, Feb 11, 2013 at 07:25:05PM +1300, Tony Prisk wrote:
> > I was just wondering if the following would be an acceptable way to turn
> > off an lcd backlight when the pwm-backlight driver is set to level 0.
> > The LCD backlight is 'powered' by the gpio.
> > 
> > leds {
> > 	compatible = "gpio-leds";
> > 	backlight {
> > 		label = "lcd-power";
> > 		gpios = <&gpio 0 0 0>;  /* bank pin active_low */
> > 		linux,default-trigger = "backlight";
> > 		default-state = "on";
> > 	};
> > };
> > 
> > The method has been tested by an end-user and confirmed as working - I
> > just wanted to check whether it is the 'accepted' way of doing it.
> 
> I don't quite see how this is related to pwm-backlight. Maybe you can
> post a more complete example? Representing the backlight power as a GPIO
> controlled LED seems somewhat kludgy.
> 
> That said, there is currently no "accepted" way to use a GPIO to control
> the power to the backlight in pwm-backlight. There was some work by Alex
> (Cc'ed) to integrate this using generic power-sequences, but there was
> some pushback on that. Your best bet currently would seem to integrate
> this with the CDF (Common Display Framework). Unfortunately that'd mean
> you'd need to write a whole new driver to abstract the panel. Even in
> CDF there are ongoing discussions about how to hook it up with the
> backlight framework. I know this doesn't give you a solution right away
> but I think it's the best way to represent the actual hardware and it
> takes into account a number of other aspect about displays as well.
> 
> Thierry


Just to clarify - I'm not looking for a way to do it immediately.

The small snippet was sent as a patch to me by an end-user and although
it worked, it just didn't 'feel' right so I thought I'd get a bit of
feedback on it.

Thanks for your thoughts.

Regards
Tony P
