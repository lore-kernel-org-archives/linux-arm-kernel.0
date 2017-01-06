From: yong.wu@mediatek.com (Yong Wu)
Date: Fri, 6 Jan 2017 14:46:04 +0800
Subject: [PATCH] iommu: Drop the of_iommu_{set/get}_ops() interface
In-Reply-To: <c61db43c-82b1-b4c9-63cb-a8c78878cb39@arm.com>
References: <20170103173456.18154-1-lorenzo.pieralisi@arm.com>
 <c61db43c-82b1-b4c9-63cb-a8c78878cb39@arm.com>
Message-ID: <1483685164.3334.3.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-01-04 at 15:11 +0000, Robin Murphy wrote:
> [+Yong Wu for mtk_iommu]
> 
> On 03/01/17 17:34, Lorenzo Pieralisi wrote:
> > With the introduction of the new iommu_{register/get}_instance()
> > interface in commit e4f10ffe4c9b ("iommu: Make of_iommu_set/get_ops() DT
> > agnostic") (based on struct fwnode_handle as look-up token, so firmware
> > agnostic) to register IOMMU instances with the core IOMMU layer there is
> > no reason to keep the old OF based interface around any longer.
> > 
> > Convert all the IOMMU drivers (and OF IOMMU core code) that rely on the
> > of_iommu_{set/get}_ops() to the new kernel interface to register/retrieve
> > IOMMU instances and remove the of_iommu_{set/get}_ops() remaining glue
> > code in order to complete the interface rework.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> Looking at before-and-after disassemblies, of_iommu.o is binary
> identical, and exynos-iommu.o differs only in the use of dev->fwnode
> rather than &dev->of_node->fwnode (and is binary identical if I hack it
> back to the latter). I'm not sure why the (GCC 6.2) codegen for
> mtk_iommu.o changes quite so much when merely replacing a callsite with
> the contents of its static inline callee, but it does :/
> 
> Robin.
> 

For MTK IOMMU,

Tested-by: Yong Wu <yong.wu@mediatek.com>

Thanks.
