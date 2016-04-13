From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 13 Apr 2016 18:11:08 +0800
Subject: [PATCH v5 6/9] irqchip/gic-v3: Parse and export virtual GIC
 information
In-Reply-To: <570BC1ED.9080200@codeaurora.org>
References: <1459769860-6629-1-git-send-email-julien.grall@arm.com>
 <1459769860-6629-7-git-send-email-julien.grall@arm.com>
 <570B35DA.5050600@linaro.org> <570BB461.4040704@arm.com>
 <570BC1ED.9080200@codeaurora.org>
Message-ID: <570E1B3C.8010800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker, Julien,

On 2016/4/11 23:25, Shanker Donthineni wrote:
> Hi Julien,
>
> On 04/11/2016 09:27 AM, Julien Grall wrote:
>> Hello Hanjun,
>>
>> On 11/04/16 06:27, Hanjun Guo wrote:
>>> On 2016/4/4 19:37, Julien Grall wrote:
>>>> +static void __init gic_acpi_setup_kvm_info(void)
>>>> +{
>>>> +    int irq;
>>>> +
>>>> +    if (!gic_acpi_collect_virt_info()) {
>>>> +        pr_warn("Unable to get hardware information used for
>>>> virtualization\n");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    gic_v3_kvm_info.type = GIC_V3;
>>>> +
>>>> +    irq = acpi_register_gsi(NULL, acpi_data.maint_irq,
>>>> +                acpi_data.maint_irq_mode,
>>>> +                ACPI_ACTIVE_HIGH);
>>>> +    if (irq <= 0)
>>>> +        return;
>>>> +
>>>> +    gic_v3_kvm_info.maint_irq = irq;
>>>> +
>>>> +    if (acpi_data.vcpu_base) {
>>>
>>> Sorry, I'm not familiar with KVM, but I got a question here, will
>>> KVM works without valid vcpu_base in GICv3 mode?
>>
> Yes, KVM works without vcpu_base in GICv3 mode. The vcpu_base will be used
> for emulatingvGICv2 feature. The vGICv3 emulation isdone through the
> system registers.
>
>> vcpu_base is only required for supporting GICv2 on GICv3.
>>
> Yes, you are right,

Thanks for the clarify.

Hanjun
