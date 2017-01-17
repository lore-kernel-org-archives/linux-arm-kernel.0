From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 17 Jan 2017 10:31:00 -0600
Subject: [RFC PATCH v2 10/10] dt-bindings: Document devicetree binding
 for ARM SPE
In-Reply-To: <20170116105904.GB1510@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
 <1484323429-15231-11-git-send-email-will.deacon@arm.com>
 <20170113184352.GE2472@leverpostej> <20170116105904.GB1510@arm.com>
Message-ID: <20170117103100.55e98029aac55ef7770350f3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jan 2017 10:59:04 +0000
Will Deacon <will.deacon@arm.com> wrote:

> On Fri, Jan 13, 2017 at 06:43:52PM +0000, Mark Rutland wrote:
> > On Fri, Jan 13, 2017 at 04:03:49PM +0000, Will Deacon wrote:
> > > +- compatible : should be one of:
> > > +	       "arm,arm-spe-pmu-v1"
> > 
> > The second "arm" here doesn't seem to add much. Should that be "armv8.2"
> > instead?
> 
> I don't think armv8.2 is particularly helpful, because that effectively ties
> together the SPE version and the architecture version, which I don't think
> is strictly required. The reason I added it was so that you could describe
> a partner implementation as something like:
> 
>   acme,arm-spe-pmu-v1
> 
> and know that it was acme's implementation of an ARM architectural feature.

Wouldn't such an implementation be compatible with an
"arm,arm-spe-pmu-v1" (or one with less "arm"s)?

> If I drop the second "arm", I was worried that it might conflict with other
> namespaces (e.g. acme's signal-processing-element's power-management-unit).

I'd personally let them worry about that, esp. because this problem
would come up first and hopefully be fixed in the marketing domain
before it reaches its device tree specification stage.

Kim
