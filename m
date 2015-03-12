From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 12 Mar 2015 15:31:57 +0800
Subject: [PATCH v10 16/21] irqchip: Add GICv2 specific ACPI boot support
In-Reply-To: <20150312051245.GI21998@io.lakedaemon.net>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-17-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6uWwts6X=Yc2ioBdQizXkF1_YgoNNOsREWirk2MFBVDHg@mail.gmail.com>
 <20150311231141.GG21998@io.lakedaemon.net> <5500EFFF.2070807@huawei.com>
 <20150312051245.GI21998@io.lakedaemon.net>
Message-ID: <550140ED.3080808@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/12 13:12, Jason Cooper wrote:
> On Thu, Mar 12, 2015 at 09:46:39AM +0800, Hanjun Guo wrote:
>> On 2015/3/12 7:11, Jason Cooper wrote:
>>> Hey Grant,
>>>
>>> On Wed, Mar 11, 2015 at 06:04:50PM +0000, Grant Likely wrote:
>>>> On 11 Mar 2015 12:42, "Hanjun Guo" <hanjun.guo@linaro.org> wrote:
[...]
>>>>> diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
>>>>> index 0fe2f71..afd1af3 100644
>>>>> --- a/drivers/irqchip/irqchip.c
>>>>> +++ b/drivers/irqchip/irqchip.c
>>>>> @@ -8,6 +8,7 @@
>>>>>   * warranty of any kind, whether express or implied.
>>>>>   */
>>>>>
>>>>> +#include <linux/acpi_irq.h>
>>>>>  #include <linux/init.h>
>>>>>  #include <linux/of_irq.h>
>>>>>  #include <linux/irqchip.h>
>>>>> @@ -26,4 +27,6 @@ extern struct of_device_id __irqchip_of_table[];
>>>>>  void __init irqchip_init(void)
>>>>>  {
>>>>>         of_irq_init(__irqchip_of_table);
>>>>> +
>>>>> +       acpi_irq_init();
>>>>>  }
>>> Is this in line with Olof's idea that providing a dtb would override ACPI?
>> Yes, it will. Since ACPI is default OFF (disabled), if a dtb provided, and no acpi=force
>> passed in the early command line, dtb will be used as system configuration for
>> boot (dtb is always the prior one for now) [1]. In acpi_gic_init() which called by
>> acpi_irq_init(), it will return immediately if acpi disabled, so it will not parse
>> any ACPI table for device configuration.
> Ok, that matches my recollection.  Thanks for refreshing my memory.  I'll apply
> this on a topic branch for irqchip/gic when I return from travel.  Most likely
> Friday or over the weekend.

Thank you very much! But this patch can't be applied without previous ones in this
patch set, how about you ack this patch and Catalin takes it via ARM64 tree? I'm
not sure for this, it depends on your decision.

Thanks
Hanjun
