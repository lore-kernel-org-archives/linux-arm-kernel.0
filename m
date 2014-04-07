From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 6 Apr 2014 19:10:15 -0700
Subject: [PATCH] Route keyboard LEDs through the generic LEDs layer.
In-Reply-To: <20140331122323.GC6044@type.bordeaux.inria.fr>
References: <20140331122323.GC6044@type.bordeaux.inria.fr>
Message-ID: <20140407021015.GA8518@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

On Mon, Mar 31, 2014 at 02:23:23PM +0200, Samuel Thibault wrote:
> This permits to reassign keyboard LEDs to something else than keyboard "leds"
> state, by adding keyboard led and modifier triggers connected to a series
> of VT input LEDs, themselves connected to VT input triggers, which
> per-input device LEDs use by default.  Userland can thus easily change the LED
> behavior of (a priori) all input devices, or of particular input devices.
> 

I still have the same concern that I believe I already mentioned a while
ago: how do we reconcile the LED control via triggers with LED control
done through event devices? Currently, as far as I can see, they will be
clashing with each other. I.e. if I remap my capslock led to be the new
shiftlock and then userspace writes EV_LED/LED_CAPSL it would light up
my new "shift lock", right?

Also I wonder if we really need to have the multiplexing (VT-level) leds
in addition to per-device ones.

Thanks.

-- 
Dmitry
