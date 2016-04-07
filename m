From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 07 Apr 2016 14:45:46 -0700
Subject: [PATCH v6 1/2] ARM: dma-mapping: Don't use outer_flush_range when
 the L2C is coherent
In-Reply-To: <20160407185704.GH19428@n2100.arm.linux.org.uk> (Russell King's
 message of "Thu, 7 Apr 2016 19:57:04 +0100")
References: <1459415380-18004-1-git-send-email-gregory.clement@free-electrons.com>
 <1459415380-18004-2-git-send-email-gregory.clement@free-electrons.com>
 <20160407185704.GH19428@n2100.arm.linux.org.uk>
Message-ID: <871t6hjdo5.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On jeu., avril 07 2016, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

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
>
> This should be named "l2_coherent" because it controls whether L2
> cache flushing is done: L1 cache flushing calls are still present.

I've just sent a new version taking into account your remark.

Thanks,

Gregory

>
> -- 
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
