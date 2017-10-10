From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 10 Oct 2017 12:16:46 +0100
Subject: [PATCH 2/3] ACPI/IORT: Improve functions return type/storage
 class specifier indentation
In-Reply-To: <59DC7ED6.50204@huawei.com>
References: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1507038811-23382-3-git-send-email-lorenzo.pieralisi@arm.com>
 <59DC7ED6.50204@huawei.com>
Message-ID: <20171010111636.GA28096@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 04:03:34PM +0800, Hanjun Guo wrote:
> On 2017/10/3 21:53, Lorenzo Pieralisi wrote:
> > Some functions definition indentations are using a style that is frowned
> > upon with return value type/storage class specifier in a separate line.
> >
> > Reindent the function definitions to fix them.
> 
> Shall we fix the functions which guarded with #ifdef CONFIG_IOMMU_API
> as well?

Yes I have a patch for that, I shall see if I can manage to squeeze it
in for 4.15.

Thanks,
Lorenzo

> Thanks
> Hanjun
> 
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Hanjun Guo <hanjun.guo@linaro.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/acpi/arm64/iort.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 69f21f3..f4775e7 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -88,8 +88,8 @@ static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
> >   *
> >   * Returns: fwnode_handle pointer on success, NULL on failure
> >   */
> > -static inline
> > -struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node)
> > +static inline struct fwnode_handle *iort_get_fwnode(
> > +			struct acpi_iort_node *node)
> >  {
> >  	struct iort_fwnode *curr;
> >  	struct fwnode_handle *fwnode = NULL;
> > @@ -306,9 +306,8 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> >  	return 0;
> >  }
> >  
> > -static
> > -struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
> > -					u32 *id_out, int index)
> > +static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
> > +					       u32 *id_out, int index)
> >  {
> >  	struct acpi_iort_node *parent;
> >  	struct acpi_iort_id_mapping *map;
> > @@ -392,10 +391,9 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
> >  	return NULL;
> >  }
> >  
> > -static
> > -struct acpi_iort_node *iort_node_map_platform_id(struct acpi_iort_node *node,
> > -						 u32 *id_out, u8 type_mask,
> > -						 int index)
> > +static struct acpi_iort_node *iort_node_map_platform_id(
> > +		struct acpi_iort_node *node, u32 *id_out, u8 type_mask,
> > +		int index)
> >  {
> >  	struct acpi_iort_node *parent;
> >  	u32 id;
> > @@ -1077,8 +1075,8 @@ static const struct iort_iommu_config iort_arm_smmu_cfg __initconst = {
> >  	.iommu_init_resources = arm_smmu_init_resources
> >  };
> >  
> > -static __init
> > -const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node *node)
> > +static __init const struct iort_dev_config *iort_get_dev_cfg(
> > +			struct acpi_iort_node *node)
> >  {
> >  	switch (node->type) {
> >  	case ACPI_IORT_NODE_SMMU_V3:
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
