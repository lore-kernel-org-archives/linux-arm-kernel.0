From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 21 Jun 2017 17:47:26 +0200
Subject: [PATCH 0/8] io-pgtable lock removal
In-Reply-To: <b7830be1-9a78-e29f-a29c-4798aaa28c0a@broadcom.com>
References: <cover.1496921366.git.robin.murphy@arm.com>
 <458ad41d-6679-eeca-3c0f-13ccb6c933b6@codeaurora.org>
 <b7830be1-9a78-e29f-a29c-4798aaa28c0a@broadcom.com>
Message-ID: <20170621154726.GQ30388@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 05:40:30PM -0700, Ray Jui wrote:
> With the NVMf target test with 4 SSDs, fio based test, random read, 4k,
> 8 jobs:
> 
> Without IOMMU:
> 
> IOPS = 1080K
> 
> With IOMMU, but without your latest patch:
> 
> IOPS = 520K
> 
> With IOMMU and your latest patch:
> 
> IOPS = 500K ~ 850K (a lot of variation observed during the same test run)

That variation might come from the RB-Tree used in the IOVA allocator.
For block-device workloads the allocation size of iova ranges might be
bigger than what is cached in the magazines, so that the fall-back to
the old (locked) allocator is used.


	Joerg
