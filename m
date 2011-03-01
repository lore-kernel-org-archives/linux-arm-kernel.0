From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 1 Mar 2011 23:31:46 +0800
Subject: [PATCH 2/3] arm: pmu: support pmu irq routed from CTI
In-Reply-To: <-294597288559385401@unknownmsgid>
References: <1298985434-3009-1-git-send-email-tom.leiming@gmail.com>
	<1298985434-3009-3-git-send-email-tom.leiming@gmail.com>
	<-294597288559385401@unknownmsgid>
Message-ID: <AANLkTi=NLTqzj_PtWFvtbGP6PcZLOy1UvtxRT3TZsYV0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2011/3/1 Will Deacon <will.deacon@arm.com>:
> Hello,
>
>> Subject: [PATCH 2/3] arm: pmu: support pmu irq routed from CTI
>>
>> From: Ming Lei <tom.leiming@gmail.com>
>>
>> This patch introduces pmu_platform_data struct to
>> support pmu irq routed from CTI, such as implemented
>> on OMAP4.
>>
>> Generally speaking, clearing cti irq should be done in
>> irq handler, also enabling cti module after calling
>> request_irq and disabling cti module before calling
>> free_irq.
>>
>> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
>> ---
>> ?arch/arm/include/asm/pmu.h ? | ? 12 ++++++++++
>> ?arch/arm/kernel/perf_event.c | ? 51 ++++++++++++++++++++++++++++++++++++-----
>> ?2 files changed, 56 insertions(+), 7 deletions(-)
>
> This will conflict with the the ux500 PMU workaround:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-February/041145.html

Thanks for your pointing out it.

I will send out -v1 of these patches against the latest -next tree.


thanks,
-- 
Lei Ming
