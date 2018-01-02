From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 2 Jan 2018 08:37:32 -0500
Subject: [PATCH V4 24/26] video: fbdev: riva: deprecate
 pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-25-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-25-git-send-email-okaya@codeaurora.org>
Message-ID: <04f4cf20-9b57-3eff-79b6-abfda1258174@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2017 12:38 AM, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> struct riva_par has a pointer to struct pci_dev. Use the pci_dev member
> to extract the domain information.
> 
> Change the function signature for CalcStateExt and RivaGetConfig to pass
> in struct pci_dev in addition to RIVA_HW_INST so that code inside the
> riva_hw.c can also calculate domain number and pass it to
> pci_get_domain_bus_and_slot().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Any feedback here, most of the remaining patches have the ACK except these?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
