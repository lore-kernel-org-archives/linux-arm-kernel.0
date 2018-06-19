From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Jun 2018 11:02:48 +0100
Subject: [PATCH] iommu/io-pgtable-arm: Fix pgtable allocation in selftest
In-Reply-To: <20180618112754.24942-1-jean-philippe.brucker@arm.com>
References: <20180618112754.24942-1-jean-philippe.brucker@arm.com>
Message-ID: <20180619100247.GE13984@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 12:27:54PM +0100, Jean-Philippe Brucker wrote:
> Commit 4b123757eeaa ("iommu/io-pgtable-arm: Make allocations
> NUMA-aware") added a NUMA hint to page table allocation, but the pgtable
> selftest doesn't provide an SMMU device parameter. Since dev_to_node
> doesn't accept a NULL argument, add a special case for selftest.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, I'll pick this up.

Will
