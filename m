From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 8 Oct 2013 16:01:52 -0700
Subject: [PATCHv2] Route kbd LEDs through the generic LEDs layer
In-Reply-To: <20130904172621.GA5957@type.bordeaux.inria.fr>
References: <20130717152916.GI5883@type.bordeaux.inria.fr>
 <20130904172621.GA5957@type.bordeaux.inria.fr>
Message-ID: <20131008160152.a98961b9e54bf1c45c1818dc@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Sep 2013 19:26:21 +0200 Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:

> This permits to reassign keyboard LEDs to something else than keyboard "leds"
> state, by adding keyboard led and modifier triggers connected to a series
> of VT input LEDs, themselves connected to VT input triggers, which
> per-input device LEDs use by default.  Userland can thus easily change the LED
> behavior of (a priori) all input devices, or of particular input devices.
> 
> This also permits to fix #7063 from userland by using a modifier to implement
> proper CapsLock behavior and have the keyboard caps lock led show that modifier
> state.

I had a version of this in -mm for a long time and there was a
1000-message email discussion which I didn't have a hope of following.

Do you believe that the earlier controversies are now addressed and if
so, how?  Have the earlier participants in that discussion been cc'ed
and have they commented?

In other words, how are we generally getting along with those things?  

I'll put this version into -mm to get it a bit of linux-next exposure,
but I'm hoping that Dmitry will process it?

The one-line change to drivers/tty/vt/keyboard.c no longer applies -
LED_SHOW_MEM has vanished altogether.
