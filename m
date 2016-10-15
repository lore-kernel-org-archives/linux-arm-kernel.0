From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 14 Oct 2016 23:50:30 -0400
Subject: [PATCH V2 1/3] Revert "ACPI, PCI,
 IRQ: reduce static IRQ array size to 16"
In-Reply-To: <09f93442-89c8-7b2c-467d-d29b857739ff@codeaurora.org>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
 <1475615720-31047-2-git-send-email-okaya@codeaurora.org>
 <20161012221357.GB15116@localhost>
 <09f93442-89c8-7b2c-467d-d29b857739ff@codeaurora.org>
Message-ID: <44177a0c-d608-d6b8-232a-ebe244d932ee@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2016 6:46 PM, Sinan Kaya wrote:
>> Which API are you thinking about here?  pcibios_penalize_isa_irq() is
>> > called by ACPI and PNP, which should both be after ACPI is started.
> Correct, I was talking about acpi_penalize_sci_irq function here.
> 

Now that I'm looking at the code. There are two more functions that get
called before ACPI start. 

These are acpi_isa_irq_available and acpi_penalize_isa_irq functions. 
We can't rely on iterating the link list.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
