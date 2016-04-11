From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 11 Apr 2016 10:25:33 -0500
Subject: [PATCH v5 6/9] irqchip/gic-v3: Parse and export virtual GIC
 information
In-Reply-To: <570BB461.4040704@arm.com>
References: <1459769860-6629-1-git-send-email-julien.grall@arm.com>
 <1459769860-6629-7-git-send-email-julien.grall@arm.com>
 <570B35DA.5050600@linaro.org> <570BB461.4040704@arm.com>
Message-ID: <570BC1ED.9080200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 04/11/2016 09:27 AM, Julien Grall wrote:
> Hello Hanjun,
>
> On 11/04/16 06:27, Hanjun Guo wrote:
>> On 2016/4/4 19:37, Julien Grall wrote:
>>> +static void __init gic_acpi_setup_kvm_info(void)
>>> +{
>>> +    int irq;
>>> +
>>> +    if (!gic_acpi_collect_virt_info()) {
>>> +        pr_warn("Unable to get hardware information used for
>>> virtualization\n");
>>> +        return;
>>> +    }
>>> +
>>> +    gic_v3_kvm_info.type = GIC_V3;
>>> +
>>> +    irq = acpi_register_gsi(NULL, acpi_data.maint_irq,
>>> +                acpi_data.maint_irq_mode,
>>> +                ACPI_ACTIVE_HIGH);
>>> +    if (irq <= 0)
>>> +        return;
>>> +
>>> +    gic_v3_kvm_info.maint_irq = irq;
>>> +
>>> +    if (acpi_data.vcpu_base) {
>>
>> Sorry, I'm not familiar with KVM, but I got a question here, will
>> KVM works without valid vcpu_base in GICv3 mode?
>
Yes, KVM works without vcpu_base in GICv3 mode. The vcpu_base will be used
for emulatingvGICv2 feature. The vGICv3 emulation isdone through the
system registers.

> vcpu_base is only required for supporting GICv2 on GICv3.
>
Yes, you are right,

> Regards,
>

-- 
Shanker Donthineni
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
