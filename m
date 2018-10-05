From: rppt@linux.vnet.ibm.com (Mike Rapoport)
Date: Fri, 05 Oct 2018 18:05:01 +0300
Subject: [PATCH] memblock: stop using implicit alignement to
 SMP_CACHE_BYTES
In-Reply-To: <8891277c7de92e93d3bfc409df95810ee6f103cd.camel@kernel.crashing.org>
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
 <8891277c7de92e93d3bfc409df95810ee6f103cd.camel@kernel.crashing.org>
Message-ID: <59C9470E-F718-4A11-BC65-FD68901723AC@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On October 5, 2018 6:25:38 AM GMT+03:00, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>On Fri, 2018-10-05 at 00:07 +0300, Mike Rapoport wrote:
>> When a memblock allocation APIs are called with align = 0, the
>alignment is
>> implicitly set to SMP_CACHE_BYTES.
>> 
>> Replace all such uses of memblock APIs with the 'align' parameter
>explicitly
>> set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
>> memblock internal allocation functions.
>> 
>> For the case when memblock APIs are used via helper functions, e.g.
>like
>> iommu_arena_new_node() in Alpha, the helper functions were detected
>with
>> Coccinelle's help and then manually examined and updated where
>appropriate.
>> 
>> The direct memblock APIs users were updated using the semantic patch
>below:
>
>What is the purpose of this ? It sounds rather counter-intuitive...

Why?
I think it actually more intuitive to explicitly set alignment to SMP_CACHE_BYTES rather than use align = 0 because deeply inside allocator it will be implicitly reset to SMP_CACHE_BYTES...

>Ben.

-- 
Sincerely yours,
Mike.
