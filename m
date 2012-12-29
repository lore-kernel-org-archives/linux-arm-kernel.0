From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 29 Dec 2012 08:55:47 +0100
Subject: [PATCH 1/5] ARM: Kirkwood: Convert NS2 to gpio-poweroff.
In-Reply-To: <20121229010742.GB1357@kw.sim.vm.gnt>
References: <1356704050-5047-1-git-send-email-andrew@lunn.ch>
 <20121229010742.GB1357@kw.sim.vm.gnt>
Message-ID: <20121229075547.GG7578@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 29, 2012 at 02:07:42AM +0100, Simon Guinot wrote:
> On Fri, Dec 28, 2012 at 03:14:10PM +0100, Andrew Lunn wrote:
> > Remove C code and add a Device Tree node in its place.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > 
> > This is untested. I've been known to get the active hi/low the wrong
> > way around so that the board powers off as the driver loads at boot
> > time. So it would be very good to have a tested-by: sign off.
> 
> Hi Andrew,
> 
> I think that GPIOs are currently broken for LaCie DT boards, due to
> commit f9e75922: "ARM: Kirkwood: Make use of mvebu pincltl and gpio
> drivers".

Hi Simon

gpio-power-off should work with either the old or the new driver.

What might not work with the old code gpio power off code with the new
new driver. So it is worth giving it a try.

> As mvbu_gpio is now used (instead of orion_gpio), pinctrl must also be
> used. I think that the pinctrl conversion is a preliminary work to the
> gpio_poweroff conversion. I realized this some weeks ago while working
> on the exactly same patch. Unfortunately, I failed to find enough time
> to fix it.
> 
> If you can afford a few days delay, let's say until the end of the next
> week, I should be able to add the pinctrl conversion patch and then also
> to test your patch on the top of that.

No rush. We have maybe another 4 weeks before we need to submit code
upstream for the next merge window.

	 Andrew
