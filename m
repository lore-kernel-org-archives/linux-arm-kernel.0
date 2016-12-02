From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 2 Dec 2016 18:07:03 +0800
Subject: [PATCH v3 11/14] ACPI: irq: introduce interrupt producer
In-Reply-To: <04573e29-6222-24f0-82f4-381367ee8bf0@gmail.com>
References: <1477408169-22217-1-git-send-email-guohanjun@huawei.com>
 <1477408169-22217-12-git-send-email-guohanjun@huawei.com>
 <04573e29-6222-24f0-82f4-381367ee8bf0@gmail.com>
Message-ID: <b7f0e4de-143e-c6ec-a597-a92c935698f0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aleksey,

On 2016/12/1 19:12, Aleksey Makarov wrote:
>
> Hi Hanjun,
>
> On 10/25/2016 09:09 PM, Hanjun Guo wrote:
>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>
>> In ACPI 6.1 spec, section 19.6.62, Interrupt Resource Descriptor Macro,
>
> [ ... ]
>
>> ---
>>  drivers/acpi/gsi.c      | 10 ++++--
>>  drivers/acpi/resource.c | 85
>> ++++++++++++++++++++++++++++++++++---------------
>>  include/acpi/acpi_bus.h |  1 +
>>  3 files changed, 68 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
>> index ee9e0f2..29ee547 100644
>> --- a/drivers/acpi/gsi.c
>> +++ b/drivers/acpi/gsi.c
>> @@ -55,13 +55,19 @@ int acpi_register_gsi(struct device *dev, u32 gsi,
>> int trigger,
>>                int polarity)
>>  {
>>      struct irq_fwspec fwspec;
>> +    struct acpi_device *adev = dev ? to_acpi_device(dev) : NULL;
>
> Why are you sure dev is always an acpi device?
> Look for example at drivers/acpi/pci_irq.c:377 where this function
> is called for a PCI device

Good catch, but I will drop this patch and use Agustin's one [1].

[1]: https://mail-archive.com/linux-kernel at vger.kernel.org/msg1283116.html

Thanks
Hanjun
