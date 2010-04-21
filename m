From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 22 Apr 2010 07:31:13 +1000
Subject: orion5x and GPIO blink question
In-Reply-To: <1271870470.1629.85.camel@rex>
References: <1271836632.2330.128.camel@pasglop> <1271870470.1629.85.camel@rex>
Message-ID: <1271885473.2330.178.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> If you have blink enabled/disabled options along with set_brightness you
> can end up in a state where you disable blinking but the brightness the
> LED is left with is effectively random. This is why the LED core does
> things that way and I stand by that as it gives defined behaviour (and
> mirrors the sysfs interface).
> 
> I appreciate in the world of GPIO controllers and the leds-gpio layer
> this is tricky to implement but this is more of a mismatch between the
> GPIO layer and the LED subsystem which was not addressed in the design
> of leds-gpio.

I do agree that it does make some amount of sense from the pure
standpoint of the LED subsystem (and I still somewhat dislike the API
with it's two output parameter function, dunno, somewhat hurts me to see
that in C :-)

You are right in that it's more of a gpio-leds issue. I'll look into
changing the prototype of gpio-leds own set_blink() to sort that out and
fix existing users, maybe this week-end. 

This is not a blocking issue for that dns323 rev C1 support anyways,
just something I noticed in passing, with the current code, the LED is
somewhat hard to be coerced into doing what I want :-)

Cheers,
Ben.
