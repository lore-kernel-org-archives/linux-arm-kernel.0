From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 11 Nov 2016 16:22:48 +0100
Subject: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
 agnostic
In-Reply-To: <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
Message-ID: <20161111152248.GS2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2016 at 02:19:36PM +0000, Lorenzo Pieralisi wrote:
> +struct iommu_fwentry {
> +	struct list_head list;
> +	struct fwnode_handle *fwnode;
> +	const struct iommu_ops *ops;
> +};

Is there a reason the iommu_ops need to be stored there? Currently it
seems that the ops are only needed to get the of_xlate fn-ptr later. And
the place where it is called the iommu-ops should also be available
through pdev->dev->bus->iommu_ops.


	Joerg
