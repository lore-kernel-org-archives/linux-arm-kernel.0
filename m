From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 11 Feb 2011 14:47:36 -0800
Subject: [PATCH 2/3] msm: iommu: Generalize platform data for multiple
	targets
In-Reply-To: <8ya7hd6kxk1.fsf@huya.qualcomm.com>
References: <1297456098-3241-1-git-send-email-stepanm@codeaurora.org>
	<1297456098-3241-2-git-send-email-stepanm@codeaurora.org>
	<1297462350.4852.31.camel@m0nster> <8ya7hd6kxk1.fsf@huya.qualcomm.com>
Message-ID: <1297464456.4852.34.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-02-11 at 14:37 -0800, David Brown wrote:
> On Fri, Feb 11 2011, Daniel Walker wrote:
> 
> > On Fri, 2011-02-11 at 12:28 -0800, Stepan Moskovchenko wrote:
> >> Make the IOMMU platform data target-independent in
> >> preparation for adding MSM8960 IOMMU support. The IOMMU
> >> configuration on MSM8x60 and MSM8960 is identical and the
> >> same platform data can be used for both.
> >> 
> >> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
> >> ---
> >>  arch/arm/mach-msm/Makefile                         |    4 +-
> >>  .../{devices-msm8x60-iommu.c => devices-iommu.c}   |   54 +++++++++----------
> >>  arch/arm/mach-msm/include/mach/msm_iomap-8x60.h    |   36 -------------
> >>  3 files changed, 28 insertions(+), 66 deletions(-)
> >>  rename arch/arm/mach-msm/{devices-msm8x60-iommu.c => devices-iommu.c} (93%)
> >
> > If it's like what you and David are suggesting I think you would need a
> > SoC designation in the filename ..
> 
> It is functionality that will be shared across multiple socs.  Putting
> the name of a specific soc would just be misleading.  Currently, it's
> our only iommu.  Support for another family that uses a different iommu
> could perhaps call it iommu2.

Your missing my point. I'm saying it doesn't look flexible enough to
allow support for multiple SoCs .. Is everything going to be identical
across all the supported socs ?

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
