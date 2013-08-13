From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 13 Aug 2013 12:59:40 +0200
Subject: [PATCH 4/9] PCI: mvebu: add support for reset on GPIO
In-Reply-To: <520A0D1D.4050609@gmail.com>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376333215-12885-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130813080956.GE9316@ulmo> <20130813103030.1e4156a1@skate>
 <20130813100348.GA28762@ulmo> <520A0D1D.4050609@gmail.com>
Message-ID: <1376391580.4039.8.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

Am Dienstag, den 13.08.2013, 12:40 +0200 schrieb Sebastian Hesselbarth:
> On 08/13/13 12:03, Thierry Reding wrote:
> > On Tue, Aug 13, 2013 at 10:30:30AM +0200, Thomas Petazzoni wrote:
> >> Dear Thierry Reding,
> >>
> >> On Tue, 13 Aug 2013 10:09:56 +0200, Thierry Reding wrote:
> >>
> >>>> +- reset-gpios: optional gpio to PERST#
> >>>> +- reset-delay-ms: delay in ms to wait after reset de-assertion
> >>>
> >>> I remember some recent discussion about this, and we now have this reset
> >>> framework, so perhaps it makes more sense to use the reset binding for
> >>> this? Cc'ing Stephen (as part of the device tree bindings maintainers
> >>> team) who was involved in that recent reset bindings discussion.
> >>
> >> I also thought about this, but the reset framework seems to be designed
> >> for "reset controller" IPs, i.e special IPs that are controlling reset
> >> signals. Looking at Documentation/devicetree/bindings/reset/reset.txt,
> >> I'm not sure to see how this would apply to GPIO-controlled reset
> >> signals.
> >
> > See:
> >
> > 	http://www.mail-archive.com/devicetree-discuss at lists.ozlabs.org/msg36900.html
> >
> > which seems to have carried over to this at some point:
> >
> > 	http://www.spinics.net/lists/devicetree/msg00521.html
> >
> > Some of the messages in between I can't find in any archive, sorry.
> 
> Thierry, Sascha,
> 
> thanks for the input. Flipping through the above discussion, I guess
> using "reset-gpios" and "reset-delay-us" should be fine?
> 
> I can also remove the delay property for now, as I cannot find a final
> conclusion about the configurable delay.

Yes, I'm in favor of using 'reset-gpios'. If we can agree on this
binding, I'll add support to the reset framework core.

> In the driver, I will stick to bare gpiolib and wait for gpio-reset
> driver to become available. Currently, we don't have sophisticated
> reset handling in pci-mvebu anyway.

Sounds good to me.

regards
Philipp
