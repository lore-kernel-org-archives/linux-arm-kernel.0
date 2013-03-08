From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 08 Mar 2013 11:50:07 -0800
Subject: [PATCH 03/10] ARM: smp_twd: Divorce smp_twd from local timer API
In-Reply-To: <20130308194802.GG11806@atomide.com>
References: <1362614646-24113-1-git-send-email-sboyd@codeaurora.org>
 <1362614646-24113-4-git-send-email-sboyd@codeaurora.org>
 <20130308004011.GD11806@atomide.com> <51393B59.3070200@codeaurora.org>
 <20130308180730.GE11806@atomide.com> <513A2B20.30805@codeaurora.org>
 <20130308194802.GG11806@atomide.com>
Message-ID: <513A40EF.8050403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/13 11:48, Tony Lindgren wrote:
> * Stephen Boyd <sboyd@codeaurora.org> [130308 10:21]:
>>
>> diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
>> index 081de6f..4ea3e9d 100644
>> --- a/arch/arm/kernel/smp_twd.c
>> +++ b/arch/arm/kernel/smp_twd.c
>> @@ -227,7 +227,7 @@ static void __cpuinit twd_calibrate_rate(void)
>>  
>>  static irqreturn_t twd_handler(int irq, void *dev_id)
>>  {
>> -       struct clock_event_device *evt = *(struct clock_event_device **)dev_id;
>> +       struct clock_event_device *evt = dev_id;
>>  
>>         if (twd_timer_ack()) {
>>                 evt->event_handler(evt);
>>
> Yup thanks that fixes it, both fixes are needed. So for this patch + the
> two fixes please feel free to add:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Great. Thanks for testing.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
