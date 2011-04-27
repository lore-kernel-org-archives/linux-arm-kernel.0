From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Wed, 27 Apr 2011 21:07:14 +0200
Subject: [PATCH] pxa/hx4700: Add hx4700 LED support
In-Reply-To: <323465.41879.qm@web29009.mail.ird.yahoo.com>
References: <323465.41879.qm@web29009.mail.ird.yahoo.com>
Message-ID: <1303931236.14964.21.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 27.04.2011, 16:05 +0100 schrieb Paul Parsons:
[...]
> > Please do not hard-code the timebase, periodtime, dutytime
> > and
> > autostopcount parameters in platform data. This should be
> > hooked up to
> > led_blink_set(), really.
> I just kept things simple. Will look into it.

Ok. An alternative would be to just disable hardware blinking for the
first version.

[...]
> > Is this relevant to the led support?
> No, but it helps to confirm the mapping between platform and asic3 GPIOs. Other mfd drivers define the label so why not asic3? If you're saying that this should be submitted as a separate patch then fair enough.

In this case yes, a separate patch would be better.

[...]
> > Where did you get this information? I don't have
> > WinCE+HaRET installed
> > right now, but I'm pretty sure that my old notes say that
> > these were
> > configured as low outputs by default, and I believe the SDG
> > Systems code
> > even triggered them as if to power the LEDs, although I'm
> > not sure of
> > that right now.
> I got it from observation. Writing the 3 LED GPIOs had no effect despite the options I tried. Reading them was a different story however; it always returned the current on/off state.
> For example:
> # echo 162 > /sys/class/gpio/export    # platform #162 = asic3 #34
> # cat /sys/class/gpio/gpio162/value
> 0
> # echo 1 > /sys/class/gpio/gpio162/value    # has no effect
> # cat /sys/class/gpio/gpio162/value
> 0
> # echo 1 > /sys/class/leds/hx4700:blue/brightness    # turn on
> # cat /sys/class/gpio/gpio162/value
> 1
> # echo 0 > /sys/class/gpio/gpio162/value    # has no effect
> # cat /sys/class/gpio/gpio162/value
> 1
> # 
> A more compelling illustration that the 3 LED GPIOs are configured as inputs comes from the amber LED, which blinks on / off for about one second each:
> # echo 160 > /sys/class/gpio/export    # platform #160 = asic3 #32
> # echo 1 > /sys/class/leds/hx4700:amber/brightness    # start blinking
> # while true; do cat /sys/class/gpio/gpio160/value; sleep 1; done
> 1
> 0
> 1
> 0
> 1
> 0
> 1
> 0
> etc...
> If anyone can demonstrate how the 3 LED GPIOs can be used as outputs then I'll be happy to revisit this.

Ok, thanks. I will look into this.

regards
Philipp
