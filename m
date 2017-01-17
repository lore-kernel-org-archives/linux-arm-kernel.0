From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jan 2017 16:50:01 +0000
Subject: [RFC PATCH v2 10/10] dt-bindings: Document devicetree binding
 for ARM SPE
In-Reply-To: <20170117103100.55e98029aac55ef7770350f3@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
 <1484323429-15231-11-git-send-email-will.deacon@arm.com>
 <20170113184352.GE2472@leverpostej> <20170116105904.GB1510@arm.com>
 <20170117103100.55e98029aac55ef7770350f3@arm.com>
Message-ID: <20170117165001.GH11939@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 10:31:00AM -0600, Kim Phillips wrote:
> On Mon, 16 Jan 2017 10:59:04 +0000 Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Jan 13, 2017 at 06:43:52PM +0000, Mark Rutland wrote:
> > > On Fri, Jan 13, 2017 at 04:03:49PM +0000, Will Deacon wrote:
> > > > +- compatible : should be one of:
> > > > +	       "arm,arm-spe-pmu-v1"
> > > 
> > > The second "arm" here doesn't seem to add much. Should that be "armv8.2"
> > > instead?
> > 
> > I don't think armv8.2 is particularly helpful, because that effectively ties
> > together the SPE version and the architecture version, which I don't think
> > is strictly required. The reason I added it was so that you could describe
> > a partner implementation as something like:
> > 
> >   acme,arm-spe-pmu-v1
> > 
> > and know that it was acme's implementation of an ARM architectural feature.
> 
> Wouldn't such an implementation be compatible with an
> "arm,arm-spe-pmu-v1" (or one with less "arm"s)?

We'd expect that, but in the case of significant divergence (e.g.
errata), we may not expect the fallback to the ARM compatible string.

That said, I'm not keen on the duplicate "arm" here, regardless.

> > If I drop the second "arm", I was worried that it might conflict with other
> > namespaces (e.g. acme's signal-processing-element's power-management-unit).
> 
> I'd personally let them worry about that, esp. because this problem
> would come up first and hopefully be fixed in the marketing domain
> before it reaches its device tree specification stage.

FWIW, I think that marketing is completely unrelated.

I can imagine we might have a clash, but I suspect it's unlikely if we
have enough oversight of the bindings (i.e. so long as we keep an eye
out, and the DT maintainers get Cc'd on anything likely to clash).

Thanks,
Mark.
