From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Feb 2012 14:53:45 +0000
Subject: [PATCH v3 0/2] Device tree support for TWL regulators
In-Reply-To: <4F4B9166.7020909@ti.com>
References: <1330338961-31765-1-git-send-email-rnayak@ti.com>
 <4F4B73C8.8070807@ti.com> <4F4B7798.6000300@ti.com>
 <20120227134112.GB3191@opensource.wolfsonmicro.com>
 <4F4B8A85.7060603@ti.com>
 <20120227140356.GF3191@opensource.wolfsonmicro.com>
 <4F4B9166.7020909@ti.com>
Message-ID: <20120227145345.GJ3191@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2012 at 03:21:26PM +0100, Cousson, Benoit wrote:

> Mmm, it is written in Rajendra's changelog:

> "-2- All common regulator nodes for twl4030 and twl6030 are
> now defined in the twl4030.dtsi and twl6030.dtsi instead of

Oh, it's buried at the end of a rather verbose inter-patch changelog,
that's not exactly visible :(

> The good point is that a missing or broken DTS will indeed not break
> the build, it will just not boot the platform properly. But that
> still an important dependency to me.

If adding device tree support breaks existing platforms something is
going wrong, while you're pulling things together device tree might not
work until all the support makes it in but the old non-DT code should
continue to function.

> >There's also more than that, there's also at least Tero submitting some
> >other stuff separately (and his stuff won't play with DT...) and I think
> >Peter also.  It really fees like there's a bunch of people working on
> >different things without talking to each other here.

> That's the problem with MFD devices that are doing everything from
> audio to power including the coffee...

Well, in this case everyone's only working on the regulator stuff, or at
least only overlapping on that.

The twl drivers aren't helping here - the structure is *very* non-standard
and seems to make updates more fiddly than they should be as you're not
just adding stuff to tables.  Every update seems to need explicit code
and per-change data adding which is making life harder.  If things
looked more standard from a code point of view it'd probably reduce the
pain a lot.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120227/c85e5a67/attachment.sig>
