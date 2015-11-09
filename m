From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 9 Nov 2015 00:45:53 -0500
Subject: [PATCH] acpi: add support for extended IRQ to PCI link
In-Reply-To: <56402E23.1070805@linux.intel.com>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <56402E23.1070805@linux.intel.com>
Message-ID: <56403311.2020806@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/9/2015 12:24 AM, Jiang Liu wrote:
>> +	u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
>> >  	u8 initialized:1;
>> >  	u8 reserved:7;
>> >  };
> Hi Sinan,
> 	This data structure become some sort of big, any idea to reduce
> memory consumption?
> Thanks,
> Gerry
>
Hi Gerry,

There are two constants in the code.

#define ACPI_PCI_LINK_MAX_POSSIBLE	16

I changed the data type above. Previously it was consuming 16 bytes now 
64 bytes.

The second one is this.

#define ACPI_MAX_IRQS 256

I changed ACPI_MAX_IRQS to 1020 from 256. Let's assume 1024.

I'm concerned about this though since you warned. This used to consume 
1024 bytes now 4096 bytes.

static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ0 timer */
...
}

Sinan

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
