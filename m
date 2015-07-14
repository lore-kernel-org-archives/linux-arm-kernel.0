From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 14 Jul 2015 08:54:15 +0200
Subject: [RESEND PATCH 1/2] pinctrl: change function behavior for per pin
 muxing controllers
In-Reply-To: <CACRpkdb3+9=seJo7w5nrJS-iURH3SnH-PYVvJCQ-S619KOcKbg@mail.gmail.com>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
 <1433948699-19800-2-git-send-email-ludovic.desroches@atmel.com>
 <557EF60D.8020007@wwwdotorg.org>
 <20150617123816.GB12295@odux.rfo.atmel.com>
 <5581988C.50000@wwwdotorg.org> <55925EB1.1030500@atmel.com>
 <CACRpkdb3+9=seJo7w5nrJS-iURH3SnH-PYVvJCQ-S619KOcKbg@mail.gmail.com>
Message-ID: <20150714065415.GD5161@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 02:07:45PM +0200, Linus Walleij wrote:
> On Tue, Jun 30, 2015 at 11:17 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> 
> > - no agreement on 3 points:
> > 1/ ways to use groups in generic pinctrl
> > 2/ ways to describe a comprehensive configuration in device tree
> > 3/ readability of a sysfs information
> >
> > - no way out on the generic pinctrl little changes that Ludovic proposed
> > as Linus W. never gave his point of view (RFC posts on April the 2nd).
> 
> Yeah I know. I am battling with this, it is one of those topics
> where you feel "eeeehhhh" and try to avoid looking at it. Sadly
> I have to...
> 
> I refer to Documentation/ManagementStyle, chapter 1,
> "Decisions".
> 
> What makes me feel uneasy about these things is that the decisions
> are irreversible due to the nature of the device tree bindings.
> 
> I am not a manager, but a maintainer...
> 
> > Ludovic explained at length our point of view and gave detailed
> > technical arguments. We don't intend to convince you, we just would like
> > the harmless modifications to be integrated.
> 
> So is it universally agreed that the changes are harmless?
> 
> If they are harmless, I would be able to revert the patch and
> nothing breaks in the world, I don't think that is the case. The
> case is a piece of code and functionality that is not AT91-specific
> but has to be maintained in the core pinctrl code forever.

If this change turns out to be wrong it doesn't necessarily have to stay
in the core pinctrl code. It can be pushed back into the AT91 driver
(and the others using it), won't be used for new bindings and after some
years can be pushed into some dark corner.

> 
> That is basically the big problem with anything device tree.
> It etches stuff in stone so it can't be changed, like ever.
> Further, the decision on whether to etch this or that is
> pushed to Linux subsystem maintainers, who are clearly
> unsuited for the task. :(
> 
> > As we preferred to give a chance to the generic pinconf/pinctrl for our
> > use by adding a little bit of flexibility, we are now in a situation
> > where we are nearly obliged to give up this approach and write a new
> > driver without the use of the generic facilities: what a pity!
> > We lost several months of useless work to match what we thought the
> > maintainer would prefer.
> >
> > So Linus, do you confirm that we won't go further with this approach?
> >
> > We are pretty disappointed by the way this interaction with the pinctrl
> > sub-system went.
> 
> I'm sorry, I am just trying to wait for consensus but it seems to
> be hard for that to happen.
> 
> Things I need:
> 
> - More DT bindings people to look at this patch.
> 
> - More other driver maintainers to look at this patch.
>   Sacha is one of those I'd like to get an opinion from
>   for example. ACKs, Reviewed-by's are always good.

I welcome the addition of the combined pin number / mux value
properties like we have in the Mediatek driver. Making the pinctrl
core aware of these defines like Ludovic did is a good idea IMO.

Sascha with two 's'

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
