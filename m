From: yang.shi@linaro.org (Shi, Yang)
Date: Mon, 5 Dec 2016 10:16:37 -0800
Subject: [PATCH] arm: kprobe: replace patch_lock to raw lock
In-Reply-To: <20161201141345.4xlceuchfkxyel75@linutronix.de>
References: <1478823475-15087-1-git-send-email-yang.shi@linaro.org>
 <20161201141345.4xlceuchfkxyel75@linutronix.de>
Message-ID: <06234a80-1908-996e-d134-3ac7d6ad5284@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/1/2016 6:13 AM, Sebastian Andrzej Siewior wrote:
> On 2016-11-10 16:17:55 [-0800], Yang Shi wrote:
>>
>> Since patch_text_stop_machine() is called in stop_machine() which disables IRQ,
>> sleepable lock should be not used in this atomic context, so replace patch_lock
>> to raw lock.
>>
>> Signed-off-by: Yang Shi <yang.shi@linaro.org>
>
> This can also go upstream.
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Yes, thanks for acking.

Russell,

Could you please consider this patch?

Thanks,
Yang

>
> Sebastian
>
