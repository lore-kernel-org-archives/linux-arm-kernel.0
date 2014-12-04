From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Dec 2014 17:18:49 +0000
Subject: [RFC] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <1417692868.9037.4.camel@pengutronix.de>
References: <52c403454c3b8fc201abe7ac74cf657638479311.1417691389.git.viresh.kumar@linaro.org>
 <1417692868.9037.4.camel@pengutronix.de>
Message-ID: <20141204171849.GX7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 12:34:28PM +0100, Lucas Stach wrote:
> Am Donnerstag, den 04.12.2014, 16:44 +0530 schrieb Viresh Kumar:

> > +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.

> This is extremely ill defined. It doesn't say in which direction the
> tolerance is to be applied. Can you go below or above the OPP specified
> voltage? For now everyone just assumes that it has to work both ways.
> Also with this binding the tolerance is applied for all OPPs, where is
> very much depends on the individual OPP.

Almost all specifications for voltages are done as either min/typ/max or
+/- a target voltage.

> If you are going to redefine OPPs anyway I would really like to see this
> property die and rather have a min/max voltage per OPP. That way you can
> properly express the OPP constraints. Most OPPs will likely allow a much
> higher voltage than their minimal specified one, except when you go over
> thermal limits with a high clock/voltage combination.

If you've got a minimum and maximum you also need to specify a target,
generally it's going to be better to go for the target voltage which may
not be the midpoint and is unlikely to be one of the bounds.  I do think
it's sensible to have the option of doing both to more closely match
datasheets.

> > +  - clock-latency: Specify the possible maximum transition latency for clock,
> > +    in unit of nanoseconds.

> Why do we need this? This is property of the clock. We should be able to
> handle this completely internally in the kernel. I don't know if the
> clock API has something like this right now, but it should be a trivial
> addition.

Or have it be part of the clock binding at any rate.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/13f8515b/attachment-0001.sig>
