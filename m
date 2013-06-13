From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 13 Jun 2013 17:23:04 +0200
Subject: [PATCH 1/2] pinctrl: add function to parse generic pinconfig
 properties from a dt node
In-Reply-To: <201306131635.21446.heiko@sntech.de>
References: <201306102139.32444.heiko@sntech.de>
 <CACRpkdb-vbdQJOeZvCEsKLatK-0BhEfUTJqmGURJGf1NWx__Ew@mail.gmail.com>
 <201306131635.21446.heiko@sntech.de>
Message-ID: <201306131723.04721.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 13. Juni 2013, 16:35:20 schrieb Heiko St?bner:
> Am Donnerstag, 13. Juni 2013, 10:11:28 schrieb Linus Walleij:
> > Tisdagen den 13:e Juni 2013 klock 12:22 AM, skrev Heiko St?bner
> > 
> > <heiko@sntech.de>:
> > > Am Mittwoch, 12. Juni 2013, 16:55:12 schrieb James Hogan:
> > >> > +static struct pinconf_generic_dt_params dt_params[] = {
> > >> > +   { "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
> > >> > +   { "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
> > >> > +   { "bias-bus-hold", PIN_CONFIG_BIAS_BUS_HOLD, 0 },
> > >> > +   { "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 0 },
> > >> > +   { "bias-pull-down", PIN_CONFIG_BIAS_PULL_DOWN, 0 },
> > >> > +   { "bias-pull-pin-default", PIN_CONFIG_BIAS_PULL_PIN_DEFAULT, 0
> > >> > }, +   { "drive-push-pull", PIN_CONFIG_DRIVE_PUSH_PULL, 0 },
> > >> > +   { "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
> > >> > +   { "drive-open-source", PIN_CONFIG_DRIVE_OPEN_SOURCE, 0 },
> > >> > +   { "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 0 },
> > >> > +   { "input-schmitt-enable", PIN_CONFIG_INPUT_SCHMITT_ENABLE, 1 },
> > >> > +   { "input-schmitt-disable", PIN_CONFIG_INPUT_SCHMITT_ENABLE, 0 },
> > >> > +   { "input-schmitt", PIN_CONFIG_INPUT_SCHMITT, 0 },
> > >> > +   { "input-debounce", PIN_CONFIG_INPUT_DEBOUNCE, 0 },
> > >> > +   { "power-source", PIN_CONFIG_POWER_SOURCE, 0 },
> > >> > +   { "slew-rate", PIN_CONFIG_SLEW_RATE, 0 },
> > >> > +   { "low-power-mode", PIN_CONFIG_LOW_POWER_MODE, 0 },
> > >> > +   { "output-low", PIN_CONFIG_OUTPUT, 0, },
> > >> > +   { "output-high", PIN_CONFIG_OUTPUT, 1, },
> > >> 
> > >> shouldn't half of these default to 1 instead of 0? i.e. it's much
> > >> nicer for the lone flag "bias-pull-up" to enable pull up rather than
> > >> disable it (you even do this in the DT example in the bindings doc).
> > > 
> > > on closer inspection it seems that you may be right.
> > 
> > Heiko can you write a patch for this? You can hit both this code and
> > the Rockchip driver at the same time for sure. Please check that
> > the bindings are consistent.
> > 
> > > The documentation to the
> > > options in the pinconf-generic header even tells that for example the
> > > pull options do have a 0 or 1 argument.
> > 
> > Yeah. Well.
> > 
> > Actually there has been plans to have the argument represent the
> > number of Ohms on the pull-up, but we haven't seen any hardware
> > that can actually select that.
> > 
> > Maybe we should add that now? It will still be that != 0 implies
> > enablement on platforms that does not support specifying the
> > pull up/down resistance.
> 
> Ok, I'll see that I get this fixed :-)

Hmm ... what is the meaning of the argument of bias-disable and bias-high-
impedance, as the kernel-doc in pinconf-generic.h does not tell?

bias-bus-hold ignores its argument and we already clarified that the pull-* do 
have != 0 or 0 argument.


Thanks
Heiko
