From: andreas.herrmann@calxeda.com (Andreas Herrmann)
Date: Thu, 31 Oct 2013 09:58:40 +0100
Subject: [PATCH 5/6] ARM: dts: Add nodes for SMMUs on Calxeda ECX-2000
In-Reply-To: <20131031011521.GE28613@mudshark.cambridge.arm.com>
References: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
 <1382127195-15261-6-git-send-email-andreas.herrmann@calxeda.com>
 <20131031011521.GE28613@mudshark.cambridge.arm.com>
Message-ID: <20131031085840.GS10330@alberich>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 09:15:21PM -0400, Will Deacon wrote:
> On Fri, Oct 18, 2013 at 09:13:14PM +0100, Andreas Herrmann wrote:
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> > ---
> >  arch/arm/boot/dts/ecx-2000.dts    |   44 +++++++++++++++++++++++++++++++++++--
> >  arch/arm/boot/dts/ecx-common.dtsi |    9 +++++---
> >  drivers/iommu/arm-smmu.c          |    2 +-
> >  include/linux/of.h                |    2 +-
> >  4 files changed, 50 insertions(+), 7 deletions(-)
> 
> [...]
> 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 5f585fc..9fc34d1 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -55,7 +55,7 @@
> >  #define ARM_SMMU_OPT_SECURE_CONFIG_ACCESS	(1 << 1)
> >  
> >  /* Maximum number of stream IDs assigned to a single device */
> > -#define MAX_MASTER_STREAMIDS		8
> > +#define MAX_MASTER_STREAMIDS		10
> 
> Maybe we should define this to be MAX_PHANDLE_ARGS instead, since we're
> really bound by the DT parsing code rather than anything else.

Agreed.

> 
> >  /* Maximum number of context banks per SMMU */
> >  #define ARM_SMMU_MAX_CBS		128
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index f95aee3..47f4857 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -67,7 +67,7 @@ struct device_node {
> >  #endif
> >  };
> >  
> > -#define MAX_PHANDLE_ARGS 8
> > +#define MAX_PHANDLE_ARGS 10
> >  struct of_phandle_args {
> >  	struct device_node *np;
> >  	int args_count;
> 
> This should be a separate patch.

Ok.

Andreas
