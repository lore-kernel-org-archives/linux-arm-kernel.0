From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Mar 2015 12:34:53 +0000
Subject: [PATCH 1/2] iommu: move pgsize_bitmap from struct iommu_ops to
 struct iommu_domain
In-Reply-To: <1973968.aLfySGl5av@avalon>
References: <1425641688-26438-1-git-send-email-will.deacon@arm.com>
 <1425641688-26438-2-git-send-email-will.deacon@arm.com>
 <1973968.aLfySGl5av@avalon>
Message-ID: <20150306123453.GK22377@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 06, 2015 at 11:57:58AM +0000, Laurent Pinchart wrote:
> On Friday 06 March 2015 11:34:47 Will Deacon wrote:
> > @@ -108,8 +109,6 @@ enum iommu_attr {
> >   * @domain_get_attr: Query domain attributes
> >   * @domain_set_attr: Change domain attributes
> >   * @of_xlate: add OF master IDs to iommu grouping
> > - * @pgsize_bitmap: bitmap of supported page sizes
> > - * @priv: per-instance data private to the iommu driver
> >   */
> >  struct iommu_ops {
> >  	bool (*capable)(enum iommu_cap);
> > @@ -144,9 +143,6 @@ struct iommu_ops {
> >  #ifdef CONFIG_OF_IOMMU
> >  	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
> >  #endif
> > -
> > -	unsigned long pgsize_bitmap;
> > -	void *priv;
> 
> The commit message doesn't mention the removal of the priv field.

Yup, that's sloppy. I'll move it into a separate patch.

Will
