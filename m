From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 11 Apr 2014 16:00:12 +0200
Subject: [PATCH] ARM: imx: propagate DI clock changes up the clock tree
 to PLL5
In-Reply-To: <CAJ+vNU0V_vXDOvergiQ2q00EFL46kGFJCvqCS=hdW5x=0rjN5Q@mail.gmail.com>
References: <E1WXuag-0007Gs-Ku@rmk-PC.arm.linux.org.uk>
 <CAJ+vNU1uzKCZxjsr+inuOi_VJbs+iR14uqXKOCr_32ZS__HrZQ@mail.gmail.com>
 <CAJ+vNU0V_vXDOvergiQ2q00EFL46kGFJCvqCS=hdW5x=0rjN5Q@mail.gmail.com>
Message-ID: <1397224812.4577.10.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

Am Donnerstag, den 10.04.2014, 21:48 -0700 schrieb Tim Harvey:
> On Thu, Apr 10, 2014 at 9:31 PM, Tim Harvey <tharvey@gateworks.com> wrote:
> > On Wed, Apr 9, 2014 at 8:39 AM, Russell King
> > <rmk+kernel@arm.linux.org.uk> wrote:
> >> Allows clk_set_rate() on the DI clocks to propagate up to PLL5.
> >>
> >> This allows imx-drm to produce the exact clock rate required with no
> >> modulation due to the fractional divider.  Modulation of the clock rate
> >> can and does prevent TVs from locking to the HDMI signal - they will
> >> report no signal rather than trying to lock to such a signal.
> >>
> >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >> ---
> >> I still have this patch which is required so that imx-drm is capable of
> >> producing HDMI clocks which are close enough to the HDMI defined
> >> frequencies such that TVs and similar can recognise the signal.  Without
> >> this, I don't get any kind of output on my TV desite imx-drm being set
> >> to the correct mode.  I have proven that this is because the HDMI clock
> >> is *very* wrong without this patch.
> >>
> >>  arch/arm/mach-imx/clk-imx6q.c | 12 ++++++------
> >>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >
> > Hi Russell,
> >
> > This fixed HDMI on the boards I'm testing it on (Gateworks Ventana).
> > Without it I encounter the same issue you describe above.
> >
> > Tested-by: Tim Harvey <tharvey@gateworks.com>
> >
> > Tim
> 
> I neglected to mention that even after this patch I do see an issue
> where the monitor does not sync if plugged in on board powerup.  The
> following is what I see with DEBUG enabled in imx-hdmi:
> 
I think this is fallout from how we handle the EDID fetch on startup. We
have patches lying around to fix this. Will post them in a minute.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
