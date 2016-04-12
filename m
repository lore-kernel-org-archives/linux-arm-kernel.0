From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 12 Apr 2016 14:55:57 +0200
Subject: [PATCH v6 1/2] ARM: dma-mapping: Don't use outer_flush_range when
 the L2C is coherent
In-Reply-To: <20160408044110.GA11802@lnxrabinv.se.axis.com> (Rabin Vincent's
 message of "Fri, 8 Apr 2016 06:41:10 +0200")
References: <1459415380-18004-1-git-send-email-gregory.clement@free-electrons.com>
 <1459415380-18004-2-git-send-email-gregory.clement@free-electrons.com>
 <20160408044110.GA11802@lnxrabinv.se.axis.com>
Message-ID: <87mvoz0yw2.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rabin,
 
 On ven., avril 08 2016, Rabin Vincent <rabin@rab.in> wrote:

> On Thu, Mar 31, 2016 at 11:09:39AM +0200, Gregory CLEMENT wrote:
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index deac58d5f1f7..1538bb293e90 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -61,7 +61,7 @@ struct arm_dma_free_args {
>>  
>>  struct arm_dma_allocator {
>>  	void *(*alloc)(struct arm_dma_alloc_args *args,
>> -		       struct page **ret_page);
>> +		       struct page **ret_page, bool is_coherent);
>>  	void (*free)(struct arm_dma_free_args *args);
>>  };
>
> Could you please add this parameter to the arm_dma_alloc_args structure
> instead?  As you see from the code, that's where all the other various
> parameters needed by the allocators are grouped.

I will do it inthe 8th version, it indeed simplify a little the patch.

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
