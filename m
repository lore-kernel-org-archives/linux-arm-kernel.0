From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Wed, 18 Jan 2017 14:02:53 -0500
Subject: [PATCH V10 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
In-Reply-To: <CAHp75VcLL9zvRXGCy2ynjhYFUgbYwJvLpCiUxjtsKmXjVFHmKA@mail.gmail.com>
References: <1484757988-23739-1-git-send-email-agustinv@codeaurora.org>
 <1484757988-23739-3-git-send-email-agustinv@codeaurora.org>
 <CAHp75VcLL9zvRXGCy2ynjhYFUgbYwJvLpCiUxjtsKmXjVFHmKA@mail.gmail.com>
Message-ID: <5bf630b0ab0b818db6e4e63a41020a55@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 2017-01-18 13:00, Andy Shevchenko wrote:
> On Wed, Jan 18, 2017 at 6:46 PM, Agustin Vega-Frias
> <agustinv@codeaurora.org> wrote:
>> ACPI extended IRQ resources may contain a ResourceSource to specify
>> an alternate interrupt controller. Introduce acpi_irq_get and use it
>> to implement ResourceSource/IRQ domain mapping.
>> 
>> The new API is similar to of_irq_get and allows re-initialization
>> of a platform resource from the ACPI extended IRQ resource, and
>> provides proper behavior for probe deferral when the domain is not
>> yet present when called.
>> 
> 
> Care to use -M -C when prepare this patch?
> 

I did use it, but the similarity index was below the default threshold.
I'll send in a new version of this patch with this fixed.

Thanks,
Agustin

>>  drivers/acpi/gsi.c      |  98 -----------------
>>  drivers/acpi/irq.c      | 282 
>> ++++++++++++++++++++++++++++++++++++++++++++++++
> 
> --
> With Best Regards,
> Andy Shevchenko

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
