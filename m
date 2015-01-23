From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Jan 2015 11:52:06 +0000
Subject: [RFC V2] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <1422013154.29475.11.camel@pengutronix.de>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
 <1422013154.29475.11.camel@pengutronix.de>
Message-ID: <20150123115206.GT21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 12:39:14PM +0100, Lucas Stach wrote:

> > +  Required properties:
> > +  - opp-khz: Frequency in kHz
> > +  - opp-microvolt: voltage in micro Volts

> Each OPP voltage should be defined by the triplet of minimum,
> nominal/typical, maximum. This lets you specify exact tolerances in each
> direction and should cover most use-cases.

> IMHO it would make sense to just define opp-microvolt as an array of
> those 3 values, so the DT doesn't get bloated with a lot more
> properties.

> A typical value for a CPU could then look like this:
> opp-microvolt = <800000 850000 1100000>

I tend to agree that this is clearer.  It might be nice to have variants
for specifying directly as a percentage but I don't think it's really
worth the complexity.

> For devices without any tolerance you can just specify the same value
> three times and be done with it:
> opp-microvolt = <900000 900000 900000>

If we change the binding to be typ/min/max rather than min/typ/max then
we could also do this by allowing either one or three values to be
specified.  That might be more worth the complexity especially given...

> > +  Optional properties:
> > +  - turbo-mode: Marks the volt-freq pair as turbo pair.
> > +  - status: Marks the node enabled/disabled.
> > +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.

> Please let's drop this.

DT bindings are supposed to be stable, this means the code should accept
old bindings and they should be documented as deprecated.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150123/949c5193/attachment.sig>
