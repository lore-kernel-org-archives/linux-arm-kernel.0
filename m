From: sricharan@codeaurora.org (Sricharan)
Date: Thu, 5 May 2016 10:40:00 +0530
Subject: [PATCH V3 2/7] documentation: iommu: Add bindings for msm,
 iommu-v0 ip
In-Reply-To: <20160504022437.GA4110@rob-hp-laptop>
References: <1462128875-20988-1-git-send-email-sricharan@codeaurora.org>
 <1462128875-20988-3-git-send-email-sricharan@codeaurora.org>
 <20160504022437.GA4110@rob-hp-laptop>
Message-ID: <000001d1a68c$648e3a90$2daaafb0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > The MSM IOMMU is an implementation compatible with the ARM VMSA
> short
> > descriptor page tables. It provides address translation for bus
> > masters outside of the CPU, each connected to the IOMMU through a port
> called micro-TLB.
> > Adding the DT bindings for the same.
> >
> > Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> > ---
> >  .../devicetree/bindings/iommu/msm,iommu-v0.txt     | 62
> ++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> > b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> > new file mode 100644
> > index 0000000..63b4f96
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> > @@ -0,0 +1,62 @@
> > +* MSM IOMMU
> > +
> > +The MSM IOMMU is an implementation compatible with the ARM VMSA
> short
> > +descriptor page tables. It provides address translation for bus
> > +masters outside of the CPU, each connected to the IOMMU through a
> port called micro-TLB.
> > +
> > +Required Properties:
> > +
> > +  - compatible: Must contain "msm,iommu-v0".
> 
> SOC specific compatible strings please.
  Ok sure. I think I missed being explicit here last time.

> 
> > +  - reg: Base address and size of the IOMMU registers.
> > +  - interrupts: Specifiers for the MMU fault interrupts. For instances
that
> > +    support secure mode two interrupts must be specified, for
non-secure
> and
> > +    secure mode, in that order. For instances that don't support secure
> mode a
> > +    single interrupt must be specified.
> > +  - #iommu-cells: The number of cells needed to specify the stream id.
This
> > +		  is always 1.
> > +  - qcom,ncb:	  The total number of context banks in the IOMMU.
> > +  - clocks	: List of clocks to be used during SMMU register access. See
> > +		  Documentation/devicetree/bindings/clock/clock-
> bindings.txt
> > +		  for information about the format. For each clock specified
> > +		  here, there must be a corresponding entry in clock-names
> > +		  (see below).
> > +
> > +  - clock-names	: List of clock names corresponding to the clocks
> specified in
> > +		  the "clocks" property (above). See
> > +		  Documentation/devicetree/bindings/clock/clock-
> bindings.txt
> > +		  for more info.
> 
> You must define how many clocks, their order and their names.
 Ok, will update this and repost

Regards,
 Sricharan
