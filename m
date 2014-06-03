From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 Jun 2014 14:01:56 +0100
Subject: [PATCH 0/4] arm:dma-mapping Refactoring iommu dma-mapping code
In-Reply-To: <1401704363-31052-1-git-send-email-ritesh.harjani@gmail.com>
References: <1401704363-31052-1-git-send-email-ritesh.harjani@gmail.com>
Message-ID: <20140603130156.GG23149@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 11:19:19AM +0100, ritesh.harjani at gmail.com wrote:
> From: Ritesh Harjani <ritesh.harjani@gmail.com>
> Hi All,

Hi Ritesh,

Thanks for the new patches. I have a few comments on the series as a whole.

> This patch series is to refractor iommu related common code from
> arch/arm/dma-mapping.c to lib/iommu-helper.c based on the various
> discussions with the maintainers/experts [1].
> 
> Currently the only user of the common lib/iommu-helper code will
> be ARM & ARM64 but later various architecture might try to use this
> iommu lib helper functions.
> 
> Major change of this refactoring starts with bringing out struct dma_iommu_mapping 
> *mapping variable from arch/arm/include/asm/device.h to include/linux/device.h
> and by moving out complete structure defination of dma_iommu_mapping to
> inclue/linux/iommu-helper.h. Link [2] give more details on why this was done,
> also this change got approval from Will Daecon [2].

Well, I can't approve changes to include/linux/device.h, so that probably
needs to be acked by Grant and/or Greg. Could you split that patch out into
a separate change please, so that it can go in independently?

Also, I think you could merge patches 2 and 3, no?

> There are 1/2 more function definitions which I can think of moving out, but
> those can be done once this patch series is approved as those are not very
> big changes.

This certainly looks good to start with, although I think you should
consider renaming the functions in the helper library so that they aren't
prefixed with double underscores. Maybe iommu_helper_* instead?

Finally, please drop the ChangeId entries from your commit messages (and
you've consistently misspelled refactor as refractor).

Will
