From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 30 Mar 2017 11:07:32 +0800
Subject: [PATCH v9 10/15] ACPI: platform-msi: retrieve dev id from IORT
In-Reply-To: <20170329173243.GA6091@red-moon>
References: <1488890410-15503-1-git-send-email-guohanjun@huawei.com>
 <1488890410-15503-11-git-send-email-guohanjun@huawei.com>
 <20170329101400.GA10807@red-moon> <58DBA010.1020002@linaro.org>
 <20170329123821.GA10988@red-moon> <58DBAFD6.7070300@linaro.org>
 <d620f35e-f335-bab5-49e0-a92375e00ea5@arm.com>
 <20170329161354.GC11297@red-moon> <20170329173243.GA6091@red-moon>
Message-ID: <58DC7674.8020301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/2017 01:32 AM, Lorenzo Pieralisi wrote:
> On Wed, Mar 29, 2017 at 05:13:54PM +0100, Lorenzo Pieralisi wrote:
>> On Wed, Mar 29, 2017 at 03:52:47PM +0100, Marc Zyngier wrote:
>>> On 29/03/17 14:00, Hanjun Guo wrote:
>>>> On 03/29/2017 08:38 PM, Lorenzo Pieralisi wrote:
>>>>> On Wed, Mar 29, 2017 at 07:52:48PM +0800, Hanjun Guo wrote:
>>>>>> Hi Lorenzo,
>>>>>>
>>>>>> On 03/29/2017 06:14 PM, Lorenzo Pieralisi wrote:
>>>>>>> Hi Hanjun, Marc,
>>>>>>>
>>>>>>> On Tue, Mar 07, 2017 at 08:40:05PM +0800, Hanjun Guo wrote:
[...]
>>>>>>>>    drivers/acpi/arm64/iort.c                     | 24 ++++++++++++++++++++++++
>>>>>>>>    drivers/irqchip/irq-gic-v3-its-platform-msi.c |  3 ++-
>>>>>>>>    include/linux/acpi_iort.h                     |  5 +++++
>>>>>>>>    3 files changed, 31 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> To simplify merging ACPI/IRQCHIP changes via different trees it
>>>>>>> would be good to split this patch; I am not sure what's the best
>>>>>>> way of handling it though given that we would end up in a merge
>>>>>>> ordering dependency anyway (ie we can create an empty stub
>>>>>>> for iort_pmsi_get_dev_id() but that would create a dependency
>>>>>>> between ARM64 and irqchip trees anyway).
>>>>>>
>>>>>> The first 12 patches for ACPI platform MSI and later 3 patches
>>>>>> for mbigen have no "physical" dependency, which means they can
>>>>>> be merged and compiled independently, they only have functional
>>>>>> dependency only.
>>>>>>
>>>>>> We already had SAS, XGE, USB and even UART drivers depend on
>>>>>> the mbigen ACPI support, so I don't think the dependency of ACPI
>>>>>> platform MSI and mbigen patches cares much if those two parts are
>>>>>> merged in one merge window, even they are merged independently via
>>>>>> different tree.
>>>>>>
>>>>>>>
>>>>>>> Please let me know what's your preferred way of handling this.
>>>>>>
>>>>>> So in my opinion, they can be merged independently via ARM64 and
>>>>>> irqchip tree with no ordering dependency, is it OK?
>>>>>
>>>>> I am speaking about merging MBIgen AND ITS patches via IRQCHIP and
>>>>> ACPI/IORT for ARM64, that's why I replied to this patch. I do not
>>>>> think that's feasible to split patches in two separate branches
>>>>> without having a dependency between them.
>>>>>
>>>>> Sure, the last three patches can go via IRQCHIP but that was not
>>>>> my question :)
>>>>
>>>> Sorry, I misunderstood that :(
>>>>
>>>> Since it's not feasible to split patches, the best way I got is that
>>>> we get Marc's ack then merge it.
>>>
>>> I believe there is a way to make this work without too much hassle. I
>>> suggest we drop the ITS change from this patch entirely, and I instead
>>> queue this patch:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-4.12&id=e6db07d0f3b6da1f8cfd485776bfefa4fcdbfc45
>>>
>>> That way, no dependency between the two trees. Lorenzo takes all the
>>> patches flagged "ACPI", I take all those flagged "irqchip" or "msi", and
>>> everything should be perfectly standalone.
>>>
>>> Thoughts?
>>
>> Perfect for me. Hanjun, I can cherry pick Marc's patch above, rework
>> this patch and post the resulting branch for everyone to have a final
>> test.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git acpi/arm64-acpi-4.12
>
> Please have a look and let me know if that's ok, I planned to send
> a PR to Catalin by the end of the week (first 7 patches up to
> 7fc3061df075 ("ACPI: platform: setup MSI domain for ACPI based platform
> device")).

Perfect for me too, Lorenzo, Marc, Thank you very much.

I'm currently in paternity leave and can't reach the machine,
I had a detail review with the patches, they looks good to me,
Ma Jun and Wei Xu will test on Hisilicon machines and give the
feedback.

Thanks
Hanjun
