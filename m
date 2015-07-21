From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Jul 2015 16:03:06 +0100
Subject: [RFC PATCH 1/4] iommu/arm-smmu: Init driver using IOMMU_OF_DECLARE
In-Reply-To: <1437152005-25092-2-git-send-email-sricharan@codeaurora.org>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
 <1437152005-25092-2-git-send-email-sricharan@codeaurora.org>
Message-ID: <20150721150306.GI31095@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Robin]

On Fri, Jul 17, 2015 at 05:53:22PM +0100, Sricharan R wrote:
> This patch uses IOMMU_OF_DECLARE to register the driver
> and the iommu_ops. So when master devices of the iommu are
> registered, of_xlate callback can be used to add the master
> configurations to the smmu driver.

I'd really prefer to do this on top of Laurent's series reworking some of
the of_xlate code and I think Robin [CC'd] is working on that. That will
also pave the way for specifying per-master SMR configuration in the
device-tree.

Will
