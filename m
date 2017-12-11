From: vigneshr@ti.com (Vignesh R)
Date: Mon, 11 Dec 2017 10:12:52 +0530
Subject: [PATCH 4/4] PCI: dwc: pci-dra7xx: Fix legacy IRQ handling
In-Reply-To: <20171208183523.GB1885@e107981-ln.cambridge.arm.com>
References: <20171201061311.16691-1-vigneshr@ti.com>
 <20171201061311.16691-5-vigneshr@ti.com>
 <20171208183523.GB1885@e107981-ln.cambridge.arm.com>
Message-ID: <f2f05d1d-c3a7-1a27-75ca-3fdc623b07bb@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 09 December 2017 12:05 AM, Lorenzo Pieralisi wrote:
> On Fri, Dec 01, 2017 at 11:43:11AM +0530, Vignesh R wrote:
>> Legacy INTD IRQ handling is broken on dra7xx due to fact that driver
>> uses hwirq in range of 1-4 for INTA, INTD whereas IRQ domain is of size
>> 4 which is numbered 0-3. Therefore when INTD IRQ line is used with
>> pci-dra7xx driver following warning is seen:
>>
>>        WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:342 irq_domain_associate+0x12c/0x1c4
>>        error: hwirq 0x4 is too large for dummy
>>
>> Fix this by using pci_irqd_intx_xlate() helper to translate the INTx 1-4
>> range into the 0-3 as done in other PCIe drivers.
>>
>> Also, iterate over all the INTx bits and call their respective IRQ
>> handlers before clearing the status register.
> 
> It seems to me that you are fixing two bugs with one patch and therefore
> I would ask you to split it in two or explain to me why we should
> consider lumping them together.
> 

Ok, I will split the patch into two in v2.


-- 
Regards
Vignesh
