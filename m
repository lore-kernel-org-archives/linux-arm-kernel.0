From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Dec 2014 10:57:49 +0000
Subject: [PATCH 1/1] iommu/arm-smmu: modify the calculation of PASize and
 SEP fields
In-Reply-To: <1418373663-9124-1-git-send-email-thunder.leizhen@huawei.com>
References: <1418373663-9124-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20141212105749.GC25781@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 08:41:03AM +0000, Zhen Lei wrote:
> 1. the calculation appear 3 times, it's good to define a function.
> 2. VA_BITS is dynamic determined by CONFIG_ARM64_VA_BITS yet, but current
>    switch..case can not cover all possible values.
> 3. change TTBCR2_ADDR_xx to ADDR_SIZE_xx, because it's not only TTBCR2 use it.

Please take a look at the pgtable rework I posted recently -- it moves a
bunch of this into a generic framework.

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/306786.html

(I plan to post v2 soon).

Will
