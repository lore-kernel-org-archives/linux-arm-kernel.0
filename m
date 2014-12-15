From: thunder.leizhen@huawei.com (leizhen)
Date: Mon, 15 Dec 2014 19:16:43 +0800
Subject: [PATCH 1/1] iommu/arm-smmu: modify the calculation of PASize
 and SEP fields
In-Reply-To: <20141212105749.GC25781@arm.com>
References: <1418373663-9124-1-git-send-email-thunder.leizhen@huawei.com>
 <20141212105749.GC25781@arm.com>
Message-ID: <548EC31B.5010809@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/12/12 18:57, Will Deacon wrote:
> On Fri, Dec 12, 2014 at 08:41:03AM +0000, Zhen Lei wrote:
>> 1. the calculation appear 3 times, it's good to define a function.
>> 2. VA_BITS is dynamic determined by CONFIG_ARM64_VA_BITS yet, but current
>>    switch..case can not cover all possible values.
>> 3. change TTBCR2_ADDR_xx to ADDR_SIZE_xx, because it's not only TTBCR2 use it.
> 
> Please take a look at the pgtable rework I posted recently -- it moves a
> bunch of this into a generic framework.
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/306786.html
> 
> (I plan to post v2 soon).
> 
> Will
> 
> .
> 

OK, I saw.
