From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 21 Oct 2016 09:13:06 -0700
Subject: [PATCH V4 2/3] Revert "ACPI,PCI,IRQ: remove SCI penalize function"
In-Reply-To: <20161021144535.GB877@localhost>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-3-git-send-email-okaya@codeaurora.org>
 <20161021015814.GC31044@localhost> <20161021144535.GB877@localhost>
Message-ID: <2a824792-486a-6251-4931-c5cc6fd67978@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2016 7:45 AM, Bjorn Helgaas wrote:
> [1] http://marc.info/?l=linux-acpi&m=145580159209240&w=2)
> 
>> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Wait a minute, I still have a question here: what about other ACPI
> arches (ia64, arm64)?  Don't they need to call acpi_penalize_sci_irq()
> somewhere?
> 

ACPI ARM64 architecture implements reduced ACPI profile which doesn't
have GED object. Instead, ARM64 architecture uses onchip peripherals
for similar functionality. If there is a need to signal interrupts,
this is done by ACPI Notify in ASL or if absolutely needed using
ACPI Generic Event Device (GED).

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
