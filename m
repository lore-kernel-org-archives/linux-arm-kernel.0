From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 3 Nov 2016 09:33:04 -0600
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 4.9
In-Reply-To: <20161028160148.GD1076@arm.com>
References: <20161028160148.GD1076@arm.com>
Message-ID: <20161103153303.GA837@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 05:01:48PM +0100, Will Deacon wrote:
>       iommu/arm-smmu: Don't inadvertently reject multiple SMMUv3s

Hmm, this patch is pretty ugly. Wouldn't it be better to have
hardware-independent init-routine in the arm-smmu-v3 driver that checks
DT whether there is an SMMU at all and if yes, sets the per-bus
iommu-ops?



	Joerg
