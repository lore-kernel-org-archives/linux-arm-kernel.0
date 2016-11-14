From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 14 Nov 2016 16:52:23 +0100
Subject: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
 agnostic
In-Reply-To: <41e3eff1-9ce6-bcfb-5716-c65ef38add63@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
 <20161109141948.19244-5-lorenzo.pieralisi@arm.com>
 <20161111152248.GS2078@8bytes.org>
 <552e674a-f434-f08f-8e16-a94544ce8e6e@arm.com>
 <20161111162736.GV2078@8bytes.org>
 <33769e3c-265f-6e89-adf9-6d35b1e03579@arm.com>
 <20161114102654.GA1677@red-moon>
 <41e3eff1-9ce6-bcfb-5716-c65ef38add63@arm.com>
Message-ID: <20161114155222.GZ2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 12:00:47PM +0000, Robin Murphy wrote:
> If we've already made the decision to move away from bus ops, I don't
> see that it makes sense to deliberately introduce new dependencies on
> them. Besides, as it stands, this patch literally implements "tell the
> iommu-core which hardware-iommus exist in the system and a seperate
> iommu_ops ptr for each of them" straight off.

Not sure which code you are looking at, but as I see it we have only
per-device iommu-ops now (with this patch). That is different from
having core-visible hardware-iommu instances where devices could link
to.

Also the rest of iommu-core code still makes use of the per-bus ops. The
per-device ops are only used for the of_xlate fn-ptr.



	Joerg
