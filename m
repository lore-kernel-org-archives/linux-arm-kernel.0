From: robdclark@gmail.com (Rob Clark)
Date: Wed, 5 Sep 2018 06:04:44 -0400
Subject: [PATCH 0/5] Qcom smmu-500 TLB invalidation errata for sdm845
In-Reply-To: <3f74124c-b09f-a92d-117d-a747d33a4561@codeaurora.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
 <20180814114009.GF28664@arm.com>
 <ad4e9f85-ff57-ad26-fb25-7b4c08683a52@codeaurora.org>
 <3f74124c-b09f-a92d-117d-a747d33a4561@codeaurora.org>
Message-ID: <CAF6AEGsuAXXtUbeteQk5ssZEqk8XLViDZH5PfxQjn6sg8+B08A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2018 at 5:22 AM Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
>
>
> On 8/14/2018 5:54 PM, Vivek Gautam wrote:
> > Hi Will,
> >
> >
> > On 8/14/2018 5:10 PM, Will Deacon wrote:
> >> Hi Vivek,
> >>
> >> On Tue, Aug 14, 2018 at 04:25:23PM +0530, Vivek Gautam wrote:
> >>> Qcom's implementation of arm,mmu-500 on sdm845 has a
> >>> functional/performance
> >>> errata [1] because of which the TCU cache look ups are stalled during
> >>> invalidation cycle. This is mitigated by serializing all the
> >>> invalidation
> >>> requests coming to the smmu.
> >> How does this implementation differ from the one supported by
> >> qcom_iommu.c?
> >> I notice you're adding firmware hooks here, which we avoided by
> >> having the
> >> extra driver. Please help me understand which devices exist, how they
> >> differ, and which drivers are intended to support them!
> >
> > IIRC, the qcom_iommu driver was intended to support the static context
> > bank - SID
> > mapping, and is very specific to the smmu-v2 version present on
> > msm8916 soc.
> > However, this is the qcom's mmu-500 implementation specific errata.
> > qcom_iommu
> > will not be able to support mmu-500 configurations.
> > Rob Clark can add more.
> > Let you know what you suggest.
>
> Rob, can you please comment about how qcom-smmu driver has different
> implementation
> from arm-smmu driver?

sorry, I missed this thread earlier.  But yeah, as you mentioned, the
purpose for qcom_iommu.c was to deal with the static context/SID
mapping.

(I guess it is all just software, and we could make qcom_iommu.c
support dynamic mapping as well, but I think then it starts to
duplicate most of arm_smmu.c, so that doesn't seem like the right
direction)

BR,
-R

> Will, in case we would want to use arm-smmu driver, what would you
> suggest for
> having the firmware hooks?
> Thanks.
>
> Best regards
> Vivek
