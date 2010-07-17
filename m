From: david.yangshuai@gmail.com (David Yang)
Date: Sat, 17 Jul 2010 15:05:25 +0800
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 ,
	withRealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <1279199872.6664.24.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTimq3E7uF4poJkqcDIomEHoS4y24D7sJWt0U44Hd@mail.gmail.com>
	<1279198607.6664.20.camel@e102109-lin.cambridge.arm.com>
	<AANLkTikezqBLFd_ECJZ9RoCf2XCNdYyWps_JKfjyQ1se@mail.gmail.com>
	<1279199872.6664.24.camel@e102109-lin.cambridge.arm.com>
Message-ID: <AANLkTikiHfOL0WMjiZnWY3RVmw89hZVFcNkqfDUYSDgG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have a question: in linux-2.6.28, there is no barriers in the IO accessors.

So,how does it prevent the reorder of the io  instructions?

On Thu, Jul 15, 2010 at 9:17 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Thu, 2010-07-15 at 14:10 +0100, David Yang wrote:
>> I have passed the test,when using wmb() and without PATCH 0/3;
>
> Great, so it's a memory ordering issue.
>
>> But,I have a ?doubt : if I use the wmb(), then the l2x0.c 's patch is
>> not needed?
>
> Correct, if you add the wmb(), none of the three ordered accessors
> patches are needed. But we'll probably push them anyway, in which case
> the wmb() becomes superfluous.
>
>> I will test the PATCH v3 0/3 ?tomorrow, without using wmb();
>
> Thanks.
>
> --
> Catalin
>
>
