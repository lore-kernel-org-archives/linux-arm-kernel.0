From: simon.guinot@sequanux.org (Simon Guinot)
Date: Sat, 29 Dec 2012 11:11:40 +0100
Subject: [PATCH 1/5] ARM: Kirkwood: Convert NS2 to gpio-poweroff.
In-Reply-To: <20121229075547.GG7578@lunn.ch>
References: <1356704050-5047-1-git-send-email-andrew@lunn.ch>
 <20121229010742.GB1357@kw.sim.vm.gnt>
 <20121229075547.GG7578@lunn.ch>
Message-ID: <20121229101140.GD1357@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 29, 2012 at 08:55:47AM +0100, Andrew Lunn wrote:
> On Sat, Dec 29, 2012 at 02:07:42AM +0100, Simon Guinot wrote:
> > On Fri, Dec 28, 2012 at 03:14:10PM +0100, Andrew Lunn wrote:
> > > Remove C code and add a Device Tree node in its place.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > ---
> > > 
> > > This is untested. I've been known to get the active hi/low the wrong
> > > way around so that the board powers off as the driver loads at boot
> > > time. So it would be very good to have a tested-by: sign off.
> > 
> > Hi Andrew,
> > 
> > I think that GPIOs are currently broken for LaCie DT boards, due to
> > commit f9e75922: "ARM: Kirkwood: Make use of mvebu pincltl and gpio
> > drivers".
> 
> Hi Simon
> 
> gpio-power-off should work with either the old or the new driver.

gpio_request fails because mvebu-gpio relies on pinctrl which is not
available on the ns2 DT board. The mpp registration is still done in
the old fashion way for the ns2 (with kirkwood_mpp_conf()).

Look at the orion_gpio_of_init() call removal in f9e75922.

> 
> What might not work with the old code gpio power off code with the new
> new driver. So it is worth giving it a try.

I have but gpio_request fails. It is the same with all the drivers
trying to get GPIOs...

> 
> > As mvbu_gpio is now used (instead of orion_gpio), pinctrl must also be
> > used. I think that the pinctrl conversion is a preliminary work to the
> > gpio_poweroff conversion. I realized this some weeks ago while working
> > on the exactly same patch. Unfortunately, I failed to find enough time
> > to fix it.
> > 
> > If you can afford a few days delay, let's say until the end of the next
> > week, I should be able to add the pinctrl conversion patch and then also
> > to test your patch on the top of that.
> 
> No rush. We have maybe another 4 weeks before we need to submit code
> upstream for the next merge window.

OK fine. I'll do that next week.

Simon

> 
> 	 Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121229/980a929b/attachment-0001.sig>
