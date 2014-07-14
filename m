From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Jul 2014 22:05:27 +0800
Subject: gpio-mxc gpio get always returns 0 for outputs for IMX6
In-Reply-To: <CA+sos7_quvZo6j9rFPvgCdYsEx6RoUNPUyvxE74K4vaNWDkGyg@mail.gmail.com>
References: <CAJ+vNU3w9Oi+dErmy9x8g6ps=eLHLNLO-w7=gn_8JtY4Kab6JQ@mail.gmail.com>
 <20140714070341.GC2197@dragon>
 <CA+sos7_quvZo6j9rFPvgCdYsEx6RoUNPUyvxE74K4vaNWDkGyg@mail.gmail.com>
Message-ID: <20140714140526.GK2197@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 02:56:06PM +0200, Beno?t Th?baudeau wrote:
> > So the question comes down to, for an output GPIO, whether the value in
> > GPIO_DR register is always identical to what we see on the pad.  If yes,
> > your patch makes sense to me.  Otherwise, we have to set SION bit to
> > read the value of an output GPIO from GPIO_PSR.
> 
> Both are not always the same. They should be the same only for sane
> hardware. GPIO_DR indicates the level that the output pad tries to
> drive, while GPIO_PSR indicates the level sensed on the pad. Thus,
> they may differ if there is an external level conflict on the pin.
> This difference may be useful in order to test if the board is
> behaving as expected or if there is anything going wrong, which is
> typically useful for board prototyping.
> 
> The software "knows" what it has set on the output pad, so having a
> get accessor for GPIO_PSR is more useful than for GPIO_DR, and it
> better fits the actual meaning of this function. GPIO_DR would
> correspond to the non-existing gpio_get_set_value() function.

Thanks for the input, Beno?t.  That's helpful.

Shawn
