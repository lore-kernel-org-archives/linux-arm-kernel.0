From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 9 Nov 2015 11:28:43 -0500
Subject: [PATCH] acpi: add support for extended IRQ to PCI link
In-Reply-To: <5640A4B8.9020602@codeaurora.org>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <56402E23.1070805@linux.intel.com> <56403311.2020806@codeaurora.org>
 <5640A4B8.9020602@codeaurora.org>
Message-ID: <5640C9BB.70003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/9/2015 8:50 AM, Timur Tabi wrote:
> Sinan Kaya wrote:
>>
>> I'm concerned about this though since you warned. This used to consume
>> 1024 bytes now 4096 bytes.
>>
>> static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
>>      PIRQ_PENALTY_ISA_ALWAYS,    /* IRQ0 timer */
>> ...
>> }
>
> As long as it's not ever put on the stack, it should be fine.
>

Alright...

If 1k global is OK, 4k global should be OK too.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
