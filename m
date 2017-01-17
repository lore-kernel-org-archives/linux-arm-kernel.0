From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jan 2017 16:45:59 +0000
Subject: [RFC PATCH v2 10/10] dt-bindings: Document devicetree binding
 for ARM SPE
In-Reply-To: <20170116105904.GB1510@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
 <1484323429-15231-11-git-send-email-will.deacon@arm.com>
 <20170113184352.GE2472@leverpostej> <20170116105904.GB1510@arm.com>
Message-ID: <20170117164559.GG11939@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 10:59:04AM +0000, Will Deacon wrote:
> On Fri, Jan 13, 2017 at 06:43:52PM +0000, Mark Rutland wrote:
> > On Fri, Jan 13, 2017 at 04:03:49PM +0000, Will Deacon wrote:
> > > This patch documents the devicetree binding in use for ARM SPE.
> > > 
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/spe-pmu.txt | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/spe-pmu.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/spe-pmu.txt b/Documentation/devicetree/bindings/arm/spe-pmu.txt
> > > new file mode 100644
> > > index 000000000000..d6540b491af4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/spe-pmu.txt
> > > @@ -0,0 +1,20 @@
> > > +* ARMv8.2 Statistical Profiling Extension (SPE) Performance Monitor Units (PMU)
> > > +
> > > +ARMv8.2 introduces the optional Statistical Profiling Extension for collecting
> > > +performance sample data using an in-memory trace buffer.
> > > +
> > > +** SPE Required properties:
> > > +
> > > +- compatible : should be one of:
> > > +	       "arm,arm-spe-pmu-v1"
> > 
> > The second "arm" here doesn't seem to add much. Should that be "armv8.2"
> > instead?
> 
> I don't think armv8.2 is particularly helpful, because that effectively ties
> together the SPE version and the architecture version, which I don't think
> is strictly required.

Sure; I was mostly going by the example of the generic timer (which
changed somewhat between ARMv7 and ARMv8), but if SPE is somewhat
decoupled from ARMv8.2 that's not a big concern.

> The reason I added it was so that you could describe
> a partner implementation as something like:
> 
>   acme,arm-spe-pmu-v1
> 
> and know that it was acme's implementation of an ARM architectural feature.

We don't seem to do this for the SMMU, or elsewhere that I am aware of.

> If I drop the second "arm", I was worried that it might conflict with other
> namespaces (e.g. acme's signal-processing-element's power-management-unit).

That does sound possible.

Another way of avoiding this would be to expand "spe" (and we can drop
"pmu", since that's not actually part of the SPE name, and implied
anyhow).

How would you feel about:

"arm,statisitical-profiling-extension-v1"

Thanks,
Mark.
