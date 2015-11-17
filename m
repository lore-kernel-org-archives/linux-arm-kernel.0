From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 17 Nov 2015 10:05:23 +0900
Subject: A problem about interrupt when booting a captured kernel
In-Reply-To: <564A2DE4.4030702@arm.com>
References: <5645B6D3.60305@huawei.com> <564A2DE4.4030702@arm.com>
Message-ID: <564A7D53.6010906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,
(Cc: Mark)

On 11/17/2015 04:26 AM, Marc Zyngier wrote:
> On 13/11/15 10:09, Yang Yingliang wrote:
>> Hi, Marc
>>
>>
>>       The kexec will boot a captured kernel while the kernel panic. But
>> it boots failed if the kernel panic in handler function of PPI. The
>> reason is that the PPI has not been 'eoi', other interrupts can not be
>> handled when booting  the captured kernel.
>>
>>       The kexec will call irq_eoi to end the irqs that have
>> IRQD_IRQ_INPROGRESS flag. But PPIs don't have this flag, so it won't be
>> ended.
>>
>>      Three ways to solve this problem we can think :
>>      1. Is there a way to reset gic like its_reset ?
>>      2. Can we add some flag for calling irq_eoi ?
>>      3. Just 'eoi' all PPIs without checking flags in kexec.
>>
>>       Please give some advice.
>
> Good timing. Please see:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/385383.html

I removed machine_kexec_mask_interrupts() from my arm64 kdump patch series[1]
due to the past discussions[2].

Is it the time that I should resurrect the code?

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/383581.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/362414.html

Thanks,
-Takahiro AKASHI

> and let me know if that fixes things for you.
>
> Thanks,
>
> 	M.
>
