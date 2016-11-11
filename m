From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 11 Nov 2016 21:55:03 +0800
Subject: [PATCH v14 5/9] clocksource/drivers/arm_arch_timer: Simplify
 ACPI support code.
In-Reply-To: <20161021112120.GC16630@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-6-git-send-email-fu.wei@linaro.org>
 <20161020165747.GD27598@leverpostej> <20161021111352.GA16630@leverpostej>
 <20161021112120.GC16630@leverpostej>
Message-ID: <5825CDB7.40606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2016 07:21 PM, Mark Rutland wrote:
> On Fri, Oct 21, 2016 at 12:14:01PM +0100, Mark Rutland wrote:
>> On Thu, Oct 20, 2016 at 05:58:17PM +0100, Mark Rutland wrote:
>>> On Thu, Sep 29, 2016 at 02:17:13AM +0800, fu.wei at linaro.org wrote:
>>>> +	arch_timer_ppi[PHYS_NONSECURE_PPI] = acpi_gtdt_map_ppi(PHYS_NONSECURE_PPI);
>>>> +	arch_timer_ppi[VIRT_PPI] = acpi_gtdt_map_ppi(VIRT_PPI);
>>>> +	arch_timer_ppi[HYP_PPI] = acpi_gtdt_map_ppi(HYP_PPI);
>>>> +	/* Always-on capability */
>>>> +	arch_timer_c3stop = acpi_gtdt_c3stop();
>>>
>>> ... I think we should check the flag on the relevant interrupt, though
>>> that's worth clarifying.
>>
>> I see I misread the spec; this is part of the common flags.
>>
>> Please ignore this point; sorry for the noise.
>
> Actually, I misread the spec this time around; the flag *can* differ per
> interrupt for the sysreg/cp15 timer, but not for the MMIO timers where
> the flag is in a common field.
>
> So please *do* consider the above.

Sorry, misread the email as well...

Check the spec again and it's per interrupt flag.

Thanks
Hanjun
