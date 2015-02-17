From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 17 Feb 2015 19:50:08 +0100
Subject: [PATCHv6 2/2] INPUT: Introduce generic trigger/LED pairs to
 input LEDs
In-Reply-To: <20150123122814.GB18514@type.bordeaux.inria.fr>
References: <20150123122814.GB18514@type.bordeaux.inria.fr>
Message-ID: <20150217185008.GA21348@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> This permits to reassign input LEDs to something else than keyboard "leds"
> state, by adding a trigger and a led for each input leds, the former being
> triggered by EV_LED events, and the latter being by default triggered by the
> former. The user can then make the LED use another trigger, including other LED
> triggers of the same keyboard.
> 
> The hardware LEDs are now not actioned from the EV_LED event any more, but from
> the per-device LED layer.

I applied patches on top of 3.20-rc0. Note that capslock LED was broken _before_ this change
on both thinkpad and desktop, and that Numlock on thinkpad did crazy stuff _before_ this 
change, too.

In default configuration, everything works as before. (Good).

echo kbd-numlock > vt::capsl/trigger makes capslock led stay on after cycling the led
(on thinkpad). heartbeat trigger works.

echo heartbeat > input4::capsl/trigger has expected effect.

echo heartbeat > input4::numl/trigger does not seem to have any effect.

Ok, it seems that numlock is just being handled specially on thinkpad (it also means 
uio keys change meaning), I guess that's nothing to worry about.

Tested-by: Pavel Machek <pavel@ucw.cz>

									Pavel
