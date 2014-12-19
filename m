From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 19 Dec 2014 14:46:41 -0800
Subject: [PATCHv4] INPUT: Route keyboard LEDs through the generic LEDs
 layer.
In-Reply-To: <20141210010214.GZ3074@type.youpi.perso.aquilenet.fr>
References: <20141210010214.GZ3074@type.youpi.perso.aquilenet.fr>
Message-ID: <20141219144641.3a549feb1ee5f2b9400f62cb@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Dec 2014 02:02:14 +0100 Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:

> This permits to reassign keyboard LEDs to something else than keyboard "leds"
> state, by adding keyboard led and modifier triggers connected to a series
> of VT input LEDs, themselves connected to VT input triggers, which
> per-input device LEDs use by default.  Userland can thus easily change the LED
> behavior of (a priori) all input devices, or of particular input devices.
> 
> This also permits to fix #7063 from userland by using a modifier to implement
> proper CapsLock behavior and have the keyboard caps lock led show that modifier
> state.
> 
> [ebroder at mokafive.com: Rebased to 3.2-rc1 or so, cleaned up some includes, and fixed some constants]
> [blogic at openwrt.org: CONFIG_INPUT_LEDS stubs should be static inline]
> [akpm at linux-foundation.org: remove unneeded `extern', fix comment layout]
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Signed-off-by: Evan Broder <evan@ebroder.net>
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Changed in this version:
> - Use kcalloc instead of kzalloc
> - to avoid any mutex order violation, defer LED update into a work callback.

Confused.  This patch is identical to the one that's presently in -mm.
