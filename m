From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Nov 2014 09:53:07 +0000
Subject: [PATCHv0 3/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <20141107075843.GD10432@pengutronix.de>
References: <cover.1415222752.git.arno@natisbad.org>
 <148403c0ab1d556cbb99d9242c65f714a77843e5.1415222752.git.arno@natisbad.org>
 <20141106055017.GL8509@sirena.org.uk> <87ppcznbyv.fsf@natisbad.org>
 <20141107075843.GD10432@pengutronix.de>
Message-ID: <20141107095307.GZ8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 08:58:43AM +0100, Uwe Kleine-K?nig wrote:
> On Fri, Nov 07, 2014 at 12:30:48AM +0100, Arnaud Ebalard wrote:
> > Mark Brown <broonie@kernel.org> writes:

> > FWIW, we had a similar discussion a while ago, during driver inclusion:
> > 
> >   http://marc.info/?l=devicetree&m=138109313118504&w=2
> > 
> > Uwe, any idea?

> What is the problem of a not-wired-up irq line? Does the rtc framework
> need to change to allow setting an alarm without the irq line being
> hooked up? Is it "only" that the alarm is missed? Irq polling probably
> isn't sensible?

The problem is that we've got operations like alarm_irq_enable() which
probably shouldn't be reporting success if we don't have an interrupt
line.  Setting the alarm with no interrupt might still be useful but
that at least ought to fail I'd expect.

> 
> I assume it's not that unusual that an rtc irq doesn't trigger a system
> irq, so having that supported nicely would be great.
> 
> Looking through the rtc's datasheet, the device is a tad more
> complicated than the current driver handles. There are two irq lines and
> three functions that can be routed through these (alarm1, alarm2 and
> clkout; not all combinations are possible).
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141107/ec400187/attachment.sig>
