From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 28 Mar 2013 18:03:00 +1300
Subject: [PATCHv2 3/7] pinctrl: gpio: vt8500: Add pincontrol driver for
 arch-vt8500
In-Reply-To: <515315F6.5040401@wwwdotorg.org>
References: <1364015633-18580-1-git-send-email-linux@prisktech.co.nz>
 <1364015633-18580-4-git-send-email-linux@prisktech.co.nz>
 <515083CB.1060908@wwwdotorg.org> <1364237467.18777.9.camel@gitbox>
 <515204F7.30502@wwwdotorg.org> <1364376206.2160.10.camel@gitbox>
 <515315F6.5040401@wwwdotorg.org>
Message-ID: <1364446980.15039.3.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-27 at 09:53 -0600, Stephen Warren wrote:
> On 03/27/2013 03:23 AM, Tony Prisk wrote:
> > On Tue, 2013-03-26 at 14:28 -0600, Stephen Warren wrote:
> >> On 03/25/2013 12:51 PM, Tony Prisk wrote:
> ...
> >>> - #gpio-cells : should be <3>.
> >>> 	1) bank
> >>> 	2) pin number
> >>> 	3) flags - should be 0
> >>>
> >>> I will clarify this in the next version.
> >>
> >> I think you should define a flag for inverted or active-low. This is
> >> typically bit 0 in the flags cell.
> >> ...
> > 
> > Stephen,
> > 
> > Do you know if there is an example of this somewhere I can look at?
> > 
> > I did a quick search through the documentation for pinctrl and gpio, but
> > I can't find any code for defining active-low in the gpio flags. There
> > seems to be plenty for defining interrupt 'modes' but nothing for
> > setting active-low.
> 
> Interrupt modes would be for the IRQ binding, not the GPIO binding.
> 
> For an example, see:
> 
> Documentation/devicetree/bindings/gpio/
> 
> > grep -i polarity *
> > gpio-74x164.txt:  the second cell is used to specify the gpio polarity:
> > gpio-adnp.txt:  - bit 0: polarity (0: normal, 1: inverted)
> > gpio_lpc32xx.txt:      - bit 0 specifies polarity (0 for normal, 1 for inverted)
> > gpio-mxs.txt:  the second cell is used to specify the gpio polarity:
> > nvidia,tegra20-gpio.txt:  - bit 0 specifies polarity (0 for normal, 1 for inverted)
> > pl061-gpio.txt:  - bit 0 specifies polarity (0 for normal, 1 for inverted)
> 
> > I also couldn't see anywhere where it was possible to interpret the
> > flags that are passed in. Assuming I add an .of_xlate, and pass, for
> > example, *flags = gpiospec[2] I can't see anywhere later on where I get
> > the chance to 'decode' the flags to perform the specific configurations.
> 
> of_get_named_gpio_flags() will return the flags.
> 
> For an example usage, see:
> 
> > drivers/mmc/core/host.c:369:		gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &flags);
> 
> (it's at that line in next-20130325 at least)
> 

Thanks Stephen, I will take a look at this and get it sorted for the
next version.

Regards
Tony P
