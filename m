From: agustinv@codeaurora.org (agustinv at codeaurora.org)
Date: Wed, 25 May 2016 10:37:36 -0400
Subject: [PATCH V3 0/2] irqchip: qcom: Add IRQ combiner driver
In-Reply-To: <1463156203-10970-1-git-send-email-agustinv@codeaurora.org>
References: <1463156203-10970-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <a7f49bb9ecfb9181d9d9f76cc45d6dbf@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding linux-arm-kernel and linux-acpi

On 2016-05-13 12:16, Agustin Vega-Frias wrote:
> Add support for IRQ combiners in the Top-level Control and Status
> Registers (TCSR) hardware block in Qualcomm Technologies chips.
> 
> The first patch adds support for ResourceSource/IRQ domain mapping
> when using Extended IRQ Resources with a specific ResourceSource.
> The core ACPI resource management code has been changed to lookup
> the IRQ domain when an IRQ resource indicates a ResourceSource,
> and register the IRQ on that domain, instead of a GSI.
> 
> The second patch takes advantage of the new capabilities to implement
> the driver for the IRQ combiners.
> 
> Changes V1 -> V2:
> * Remove use of GPIO library for the combiner
> * Refactor to use fwnode/ResourceSource to IRQ domain mapping
>   introduced in ACPI core
> 
> Changes V2 -> V3:
> * Removed parsing of _PRS to find IRQs
> * Removed acpi_irq_domain_create and acpi_irq_domain_remove
> 
> Agustin Vega-Frias (2):
>   ACPI: Add support for ResourceSource/IRQ domain mapping
>   irqchip: qcom: Add IRQ combiner driver
> 
>  drivers/acpi/Makefile               |   1 +
>  drivers/acpi/irqdomain.c            | 108 +++++++++++
>  drivers/acpi/resource.c             |  23 ++-
>  drivers/irqchip/Kconfig             |   8 +
>  drivers/irqchip/Makefile            |   1 +
>  drivers/irqchip/qcom-irq-combiner.c | 344 
> ++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h                |   6 +
>  7 files changed, 483 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/acpi/irqdomain.c
>  create mode 100644 drivers/irqchip/qcom-irq-combiner.c
> 
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
> Forum,
> a Linux Foundation Collaborative Project.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project.
