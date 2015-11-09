From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 9 Nov 2015 07:50:48 -0600
Subject: [PATCH] acpi: add support for extended IRQ to PCI link
In-Reply-To: <56403311.2020806@codeaurora.org>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <56402E23.1070805@linux.intel.com> <56403311.2020806@codeaurora.org>
Message-ID: <5640A4B8.9020602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya wrote:
>
> I'm concerned about this though since you warned. This used to consume
> 1024 bytes now 4096 bytes.
>
> static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
>      PIRQ_PENALTY_ISA_ALWAYS,    /* IRQ0 timer */
> ...
> }

As long as it's not ever put on the stack, it should be fine.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
