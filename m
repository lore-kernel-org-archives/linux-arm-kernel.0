From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 22 Dec 2015 11:47:15 +0200
Subject: [PATCH v3 1/3] ACPI: amba bus probing support
In-Reply-To: <56789147.8070602@mleia.com>
References: <1450716100-13688-1-git-send-email-aleksey.makarov@linaro.org>
 <1450716100-13688-2-git-send-email-aleksey.makarov@linaro.org>
 <56789147.8070602@mleia.com>
Message-ID: <CAHp75VfiUJymwxxHxr-Cw3cSBDfVBm1aj=T5o+=1G4CcACq5kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 1:54 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:
> On 21.12.2015 18:41, Aleksey Makarov wrote:

>> +static int amba_handler_attach(struct acpi_device *adev,
>> +                             const struct acpi_device_id *id)
>> +{
>> +     struct amba_device *dev = NULL;
>> +     struct acpi_device *acpi_parent;
>> +     struct resource_entry *rentry;
>> +     struct list_head resource_list;
>> +     struct resource *resources = NULL;
>> +     bool address_found = false;
>> +     int ret, count, irq_no = 0;
>> +
>> +     /* If the ACPI node already has a physical device attached, skip it. */
>> +     if (adev->physical_node_count)
>> +             return 0;
>> +
>> +     amba_register_dummy_clk();
>
> Since it is a single time dummy clock registration, may be it is better
> to move it to acpi_amba_init() or somewhere else? I understand that
> "apb_pclk" is wanted, but I'm not sure that this driver should serve as
> a clock provider.

Depends on actual hardware topology. Intel HW has few drivers that are
clock providers because they are really ones.

-- 
With Best Regards,
Andy Shevchenko
