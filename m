From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Tue, 29 Nov 2016 10:14:22 -0500
Subject: [PATCH V7 0/3] irqchip: qcom: Add IRQ combiner driver
In-Reply-To: <4126fa80-c8da-764f-9ea3-ec9966a19ea9@linaro.org>
References: <1479074375-2629-1-git-send-email-agustinv@codeaurora.org>
 <4126fa80-c8da-764f-9ea3-ec9966a19ea9@linaro.org>
Message-ID: <467d339ba4998e74d7951cf424c055e4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On 2016-11-29 06:31, Hanjun Guo wrote:
> Hi Agustin,
> 
> On 2016/11/14 5:59, Agustin Vega-Frias wrote:
>> Add support for IRQ combiners in the Top-level Control and Status
>> Registers (TCSR) hardware block in Qualcomm Technologies chips.
>> 
>> The first patch fixes IRQ probe deferral by allowing platform_device
>> IRQ resources to be re-initialized if the ACPI core failed to find
>> the IRQ domain during ACPI bus scan.
>> 
>> The second patch adds support for ResourceSource/IRQ domain mapping
>> when using Extended IRQ Resources with a specific ResourceSource.
>> These changes are conditional on the ACPI_GENERIC_GSI config.
>> 
>> The third patch takes advantage of the new capabilities to implement
>> the driver for the IRQ combiners.
>> 
>> Tested on top of v4.9-rc4.
>> 
>> Changes V6 -> V7:
>> * Consolidate changes for ResourceSource/IRQ domain mapping to the 
>> same
>>   source file implementing the generic GSI support, making it 
>> conditional
>>   on CONFIG_ACPI_GENERIC_GSI.
>> * Eliminate some code duplication by implementing acpi_register_gsi in
>>   terms of the new acpi_register_irq API.
> 
> I had a test on Hisilicon D03 which needs patch 1 and 2 in this patch
> set to enable the mbigen irqchip, and it works pretty good.
> 
> Patch 1/3 can remove the device dependency for the irqchip and platform
> devices, and I removed my patch (ACPI: irq: introduce interrupt
> producer) then add your patch 2/3, devices such as SAS and native
> network works fine on my D03.

Thanks for testing. I will submit V8 with some of the changes suggested
by Lorenzo hopefully later today.

Agustin

> 
> I will comment on the patches later.
> 
> Thanks
> Hanjun

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
