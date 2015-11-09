From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Mon, 9 Nov 2015 16:45:18 +0800
Subject: [PATCH] acpi: add support for extended IRQ to PCI link
In-Reply-To: <56403311.2020806@codeaurora.org>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <56402E23.1070805@linux.intel.com> <56403311.2020806@codeaurora.org>
Message-ID: <56405D1E.6020007@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/11/9 13:45, Sinan Kaya wrote:
> 
> 
> On 11/9/2015 12:24 AM, Jiang Liu wrote:
>>> +    u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
>>> >      u8 initialized:1;
>>> >      u8 reserved:7;
>>> >  };
>> Hi Sinan,
>>     This data structure become some sort of big, any idea to reduce
>> memory consumption?
>> Thanks,
>> Gerry
>>
> Hi Gerry,
> 
> There are two constants in the code.
> 
> #define ACPI_PCI_LINK_MAX_POSSIBLE    16
> 
> I changed the data type above. Previously it was consuming 16 bytes now
> 64 bytes.
Aha, I made a mistake. ACPI_PCI_LINK_MAX_POSSIBLE hasn't been changed,
so the space increasing is not so big:)

> 
> The second one is this.
> 
> #define ACPI_MAX_IRQS 256
> 
> I changed ACPI_MAX_IRQS to 1020 from 256. Let's assume 1024.
> 
> I'm concerned about this though since you warned. This used to consume
> 1024 bytes now 4096 bytes.
> 
> static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
>     PIRQ_PENALTY_ISA_ALWAYS,    /* IRQ0 timer */
> ...
> }
> 
> Sinan
> 
