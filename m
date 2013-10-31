From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Thu, 31 Oct 2013 10:16:57 +0100
Subject: [PATCH 6/6] documentation/iommu: Update description of ARM
 System MMU binding
In-Reply-To: <CAL_JsqKV4r9eYMT4NazmGJTEGtwg+XuvTE3rH3pEL_h7nyvb-w@mail.gmail.com>
References: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
 <1382127195-15261-7-git-send-email-andreas.herrmann@calxeda.com>
 <20131031011715.GF28613@mudshark.cambridge.arm.com>
 <CAL_JsqKV4r9eYMT4NazmGJTEGtwg+XuvTE3rH3pEL_h7nyvb-w@mail.gmail.com>
Message-ID: <20131031091657.GT10330@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 02:45:55AM -0400, Rob Herring wrote:
> On Wed, Oct 30, 2013 at 8:17 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Oct 18, 2013 at 09:13:15PM +0100, Andreas Herrmann wrote:
> >> This patch adds descriptions fore new properties of device tree
> >> binding for the ARM SMMU architecture. These properties control
> >> arm-smmu driver options.
> >>
> >> Cc: Rob Herring <robherring2@gmail.com>
> >> Cc: Grant Likely <grant.likely@linaro.org>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> >> ---
> >>  .../devicetree/bindings/iommu/arm,smmu.txt         |   12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> >> index e34c6cd..de88cf9 100644
> >> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> >> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> >> @@ -48,6 +48,17 @@ conditions.
> >>                    from the mmu-masters towards memory) node for this
> >>                    SMMU.
> >>
> >> +- arm,smmu-isolate-devices : Enable device isolation for all masters
> >> +                             of this SMMU. Ie. each master will be
> >> +                             attached to its own iommu domain.
> >> +
> >> +- arm,smmu-secure-config-access : Enable proper handling of buggy
> >> +                                  implementations that always use
> >> +                                  secure access to SMMU configuration
> >> +                                  registers. In this case non-secure
> >> +                                  aliases of secure registers have to
> >> +                                  be used during SMMU configuration.
> >
> > Why are you using the "arm" vendor prefix for the secure config access
> > stuff? Wouldn't it make more sense to use "calxeda", just in case somebody
> > else finds a different way to wire things up in this regard?

I think in an early version I've used calxeda prefix but later thought
it has to match the arm prefix. I'm also fine with
calxeda,smmu-secure-config-access. But in case someone else screws
this up in a similar way and needs the same driver behaviour it's odd
if XYZ has to use the calxeda prefix instead of the arm prefix for
this option.

> I think that the property prefix should match the compatible vendor
> prefix. You could then argue that the compatible string itself should
> be prefixed with "calxeda". In that case, this property would not be
> needed at all as you could just key off the compatible string to
> determine this characteristic. Of the options, my preference would be
> just to leave things as is.

I think Will's main point is that Calxeda has a bug in the wiring and
that this is not ARM's fault. Renaming the prefix will kind of
emphasize this. In case we keep the arm prefix, how about modifying
the description for the option to state that currently only Calxeda
ECX-2000 screwed up the wiring?


Andreas
