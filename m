From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 27 Sep 2016 14:25:43 +0100
Subject: [RFC] irqchip/gic-v3: Implement suspend and resume callbacks
In-Reply-To: <57EA6774.2060807@codeaurora.org>
References: <1474447359-29551-1-git-send-email-clingutla@codeaurora.org>
 <57E25C8E.7080502@arm.com> <57EA6774.2060807@codeaurora.org>
Message-ID: <bfaa6b63-4187-198a-5d0a-f2ba3c1ffa20@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/09/16 13:35, Chandra Sekhar Lingutla wrote:
> On 09/21/2016 03:40 PM, Marc Zyngier wrote:
>> +Sudeep, Lorenzo,

[...]

>>
>> But here's my fundamental objection: None of that should be required and
>> setting (IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND) as part of the
>> irqchip flags should be enough.
>>
>> Can you explain why this doesn't work for you?
>>
> These flags work for me, I will remove suspend/resume functions, but i
> think it is very useful to know the wakeup source for debugging purposes.
> Please let me know, if you have any better way to achieve this.
>

I don't understand what's missing ? As the user you can set the wakeup
source if it's wakeup capable. You will find the sysfs entries which can
say if it's enabled or not. You can use the same to enable it.

I am not sure what you mean by "it is very useful to know the wakeup
source for debugging purposes".

-- 
Regards,
Sudeep
