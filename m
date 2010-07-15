From: david.yangshuai@gmail.com (David Yang)
Date: Thu, 15 Jul 2010 21:10:12 +0800
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 ,
	withRealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <1279198607.6664.20.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTimq3E7uF4poJkqcDIomEHoS4y24D7sJWt0U44Hd@mail.gmail.com>
	<1279198607.6664.20.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTikezqBLFd_ECJZ9RoCf2XCNdYyWps_JKfjyQ1se@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have passed the test,when using wmb() and without PATCH 0/3;

But,I have a  doubt : if I use the wmb(), then the l2x0.c 's patch is
not needed?


I will test the PATCH v3 0/3  tomorrow, without using wmb();



Thanks!

On Thu, Jul 15, 2010 at 8:56 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, 2010-07-15 at 13:52 +0100, David Yang wrote:
>> the patch v3 2/3 can not be patched to my ?arch/arm/mm/cache-l2x0.c
>> from linux-2.6.33-arm1
>>
>> should I modify it manually?
>
> It's just a simple replacement - s/writel/writel_relaxed/
>
> --
> Catalin
>
>
