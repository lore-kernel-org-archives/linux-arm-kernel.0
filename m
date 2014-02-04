From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 4 Feb 2014 17:45:56 -0600
Subject: [PATCH v2 1/5] ARM: msm: kill off hotplug.c
In-Reply-To: <20140204230707.GD20528@codeaurora.org>
References: <1391553532-27001-1-git-send-email-galak@codeaurora.org>
 <1391553532-27001-2-git-send-email-galak@codeaurora.org>
 <20140204230707.GD20528@codeaurora.org>
Message-ID: <CE29C478-50CA-4CC8-9E80-AA9C22D9B17F@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Feb 4, 2014, at 5:07 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 02/04, Kumar Gala wrote:
>> diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
>> index 3721b31..251a91e 100644
>> --- a/arch/arm/mach-msm/platsmp.c
>> +++ b/arch/arm/mach-msm/platsmp.c
>> @@ -29,6 +29,13 @@ extern void secondary_startup(void);
>> 
>> static DEFINE_SPINLOCK(boot_lock);
>> 
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +static void __ref msm_cpu_die(unsigned int cpu)
> 
> We shouldn't need __ref anymore either right?

I think we might as cpu_die is still marked __ref so I think we need it.

> 
>> +{
>> +	wfi();
>> +}
>> +#endif
>> +
>> static inline int get_core_count(void)
>> {
>> 	/* 1 + the PART[1:0] field of MIDR */
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
