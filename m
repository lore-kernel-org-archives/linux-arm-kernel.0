From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 23 Jan 2012 15:24:26 -0800
Subject: How to represent active low ARM GIC interrupts, enabled by
 external inverter?
In-Reply-To: <4F1DE962.6030906@gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF178CB81BA2@HQMAIL01.nvidia.com>
 <20120123223315.GB1068@n2100.arm.linux.org.uk> <4F1DE962.6030906@gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178CB81C21@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring wrote at Monday, January 23, 2012 4:13 PM:
> On 01/23/2012 04:33 PM, Russell King - ARM Linux wrote:
> > On Mon, Jan 23, 2012 at 01:18:50PM -0800, Stephen Warren wrote:
> >> I'd like guidance on how to model one aspect of Tegra's interrupt
> >> structure.
> >>
> >> Tegra has an interrupt input pin for use by a PMU chip.
> >>
> >> The PMC HW module within Tegra can optionally invert this signal, but
> >> otherwise has no control over it; no interrupt status bits, no masking,
> >> etc.
> >>
> >> The (potentially inverted) signal is then fed into the ARM GIC, which
> >> supports level high or rising edge interrupts only.
> 
> Stephen, isn't this the same question you posted before except where the
> inverter is is different?
> 
> http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-December/009880.html

That is somewhat similar, but I don't think quite the same:

* That thread deals with a single interrupt source and a single sink, which
need to negotiate to use one of n possible interrupt types. Whereas this
thread is about a sink connected to a source+sink connected to a sink.

* That thread dealt with negotiating one of n supported types, whereas
this thread is about a restricted sink (GIC only supporting high types),
connecting through an intermediary to a source, and I have no idea whether
that source is flexible and can support both high or low types; I assume
it can only support low types.

I suppose if the auto-negotiation logic were enhanced to jump across n
levels instead of just 1 link, it might be applicable. That sounds complex
though.

-- 
nvpublic
