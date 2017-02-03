From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 3 Feb 2017 18:31:48 +0800
Subject: [PATCH V12 0/3] irqchip: qcom: Add IRQ combiner driver
In-Reply-To: <1486077839-25547-1-git-send-email-agustinv@codeaurora.org>
References: <1486077839-25547-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <58945C14.2090009@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/2/3 7:23, Agustin Vega-Frias wrote:
> Add support for IRQ combiners in the Top-level Control and Status
> Registers (TCSR) hardware block in Qualcomm Technologies chips.
>
> The first patch prevents the ACPI core from attempting to map IRQ resources
> with a valid ResourceSource as GSIs.
>
> The second patch adds support for ResourceSource/IRQ domain mapping and
> fixes IRQ probe deferral by allowing platform_device IRQ resources to be
> re-initialized from the corresponding ACPI IRQ resource.
>
> Both changes described above are conditional on the ACPI_GENERIC_GSI config.
>
> The third patch takes advantage of the new capabilities to implement
> the driver for the IRQ combiners.
>
> Tested on top of v4.10-rc6.
>
> Changes V11 -> V12:
> * Remove probe table, add that optimization later.
> * Fix some minor style issues.

For patch [1-2/3], I tested on x86 and IA64 machine, didn't see
regressions in dmesg, and tested them on Hisilicon D03 (ARM64 with
mbigen irqchip which needs this mechanism) , it works fine.

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
