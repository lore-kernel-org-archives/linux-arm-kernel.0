From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 2 Jan 2018 08:38:03 -0500
Subject: [PATCH V4 23/26] video: fbdev: nvidia: deprecate
 pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-24-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-24-git-send-email-okaya@codeaurora.org>
Message-ID: <6a6b51ff-42d5-29cc-167e-f4ed74d7ac36@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2017 12:37 AM, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 
> struct nvidia_par has a pointer to struct pci_dev. Use the pci_dev
> member to extract the domain information and pass it to
> pci_get_domain_bus_and_slot() function.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Any feedback here ? most of the remaining patches have the ACK except these.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
