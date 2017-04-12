From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 12 Apr 2017 13:48:15 -0400
Subject: [PATCH] arm64: acpi: Support PCI devices numa_node property in
 ACPI mode
In-Reply-To: <855540a9-888d-6419-3add-d8b0dbb43029@codeaurora.org>
References: <0dada57f-4215-4ced-482d-88203857e06d@codeaurora.org>
 <20170412170433.GA7412@red-moon>
 <855540a9-888d-6419-3add-d8b0dbb43029@codeaurora.org>
Message-ID: <5f01eac0-37a2-392e-eb42-a9ac85a2eebc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/12/2017 1:27 PM, Sinan Kaya wrote:
> I am not a big fan of this. I wonder if we could not make it DT/ACPI
> agnostic by simply setting the numa_node in the pci_bus->dev field,
> and propagate it downstream a PCI hierarcy (as we do with sysdata)
> in pci_alloc_child_bus().

I didn't realize that we were pushing sysdata to the child buses. No
issues then. 

I was under the impression that sysdata only existed for the host bridge
itself and was not shared with the rest of the bus.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
