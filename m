From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 9 Dec 2014 23:15:37 -0800
Subject: [PATCHv4] INPUT: Route keyboard LEDs through the generic LEDs
 layer.
In-Reply-To: <5487EFAC.3070402@openwrt.org>
References: <20141210010214.GZ3074@type.youpi.perso.aquilenet.fr>
 <5487EFAC.3070402@openwrt.org>
Message-ID: <20141209231537.42052501.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Dec 2014 08:01:00 +0100 John Crispin <blogic@openwrt.org> wrote:

> Hi
> 
> On 10/12/2014 02:02, Samuel Thibault wrote:
> > This permits to reassign keyboard LEDs to something else than keyboard "leds"
> > state, by adding keyboard led and modifier triggers connected to a series
> > of VT input LEDs, themselves connected to VT input triggers, which
> > per-input device LEDs use by default.  Userland can thus easily change the LED
> > behavior of (a priori) all input devices, or of particular input devices.
> > 
> > This also permits to fix #7063 from userland by using a modifier to implement
> > proper CapsLock behavior and have the keyboard caps lock led show that modifier
> > state.
> > 
> > [ebroder at mokafive.com: Rebased to 3.2-rc1 or so, cleaned up some includes, and fixed some constants]
> > [blogic at openwrt.org: CONFIG_INPUT_LEDS stubs should be static inline]
> > [akpm at linux-foundation.org: remove unneeded `extern', fix comment layout]
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > Signed-off-by: Evan Broder <evan@ebroder.net>
> > Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
> > Tested-by: Pavel Machek <pavel@ucw.cz>
> > Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> > Signed-off-by: John Crispin <blogic@openwrt.org>
> 
> I am not sure why my SoB was added. I originally sent a trivial fix up
> for a header file as linux-next was not building (this was a year or
> more ago). I never reviewed this patch nor have I tested it and I
> certainly was not involved in the development. the patch simply broke
> the compile of the Mips based Wifi and DSL SoCs that i maitain.
> 
> ...
>
> this #else part was added by me to make sure that linux-next was
> building again. this really does not qualify my SoB being added.
> 

The SOB is appropriate - you made a change to the code and (presumably)
attached your SOB to that.  The change is briefly described there:

> [blogic at openwrt.org: CONFIG_INPUT_LEDS stubs should be static inline]
