From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 22 Mar 2017 16:38:50 +0100
Subject: [RFC PATCH 22/30] iommu: Bind/unbind tasks to/from devices
In-Reply-To: <20170227195441.5170-23-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-23-jean-philippe.brucker@arm.com>
Message-ID: <20170322153850.GD7266@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Philippe,

On Mon, Feb 27, 2017 at 07:54:33PM +0000, Jean-Philippe Brucker wrote:
> +extern int iommu_set_svm_ops(struct device *dev,
> +			     const struct iommu_svm_ops *svm_ops);
> +extern int iommu_bind_task(struct device *dev, struct task_struct *task,
> +			   int *pasid, int flags, void *priv);
> +
> +extern int iommu_unbind_task(struct device *dev, int pasid, int flags);

I really like that API, it is simpler than what the AMD driver
currently implements but should work for it too (once we adapt the
AMD-KFD driver to it).

One issue I like to have discussed is whether we can make a global PASID
allocation (with a one-PASID per-task model) workable with SMMU too.



	Joerg
