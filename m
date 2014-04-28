From: will.deacon@arm.com (Will Deacon)
Date: Mon, 28 Apr 2014 20:37:10 +0100
Subject: [RFC PATCH v5 02/11] ARM SMMU: Add capability IOMMU_CAP_DMA_EXEC
In-Reply-To: <1398700371-20096-3-git-send-email-a.motakis@virtualopensystems.com>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
 <1398700371-20096-3-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <20140428193709.GE22135@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 04:52:42PM +0100, Antonios Motakis wrote:
> The ARM SMMU can take an IOMMU_EXEC protection flag in addition to
> IOMMU_READ and IOMMU_WRITE. Expose this as an IOMMU capability.

The other way of handling this would be to negate the capability and
advertise a NOEXEC cap instead. That would need the IOMMU_EXEC flag to
become IOMMU_NOEXEC and the ARM SMMU driver updating accordingly, but it
might make more sense if people don't object to mixing positive and negative
logic in the IOMMU_* flags.

Any thoughts?

Will
