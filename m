From: ddaney@caviumnetworks.com (David Daney)
Date: Mon, 11 Apr 2016 17:24:20 -0700
Subject: [PATCH v2 2/4] PCI: Provide common functions for ECAM mapping
In-Reply-To: <1460414707-19153-3-git-send-email-jchandra@broadcom.com>
References: <1460414707-19153-1-git-send-email-jchandra@broadcom.com>
 <1460414707-19153-3-git-send-email-jchandra@broadcom.com>
Message-ID: <570C4034.20105@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2016 03:45 PM, Jayachandran C wrote:
> Add config option PCI_GENERIC_ECAM and file drivers/pci/ecam.c to
> provide generic functions for accessing memory mapped PCI config space.
>
> The API is defined in drivers/pci/ecam.h and is written to replace the
> API in drivers/pci/host/pci-host-common.h. The file defines a new
> 'struct pci_config_window' to hold the information related to a PCI
> config area and its mapping. This structure is expected to be used as
> sysdata for controllers that have ECAM based mapping.
>
> Helper functions are provided to setup the mapping, free the mapping
> and to implement the map_bus method in 'struct pci_ops'
>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>

Tested-by: David Daney <david.daney@cavium.com>


> ---
>   drivers/pci/Kconfig  |   3 ++
>   drivers/pci/Makefile |   2 +
>   drivers/pci/ecam.c   | 130 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/pci/ecam.h   |  58 +++++++++++++++++++++++

I wonder if these files should go in drivers/pci/host ...  I understand 
that you still have to use them from drivers/pci/acpi though.

I will let others opine on this, but could you put the contents of 
ecam.h into include/linux/pci.h along with the  pci_generic_config_*() 
declarations?

If you did that, the contents of ecam.c could  go into 
drivers/pci/access.c...


>   4 files changed, 193 insertions(+)
>   create mode 100644 drivers/pci/ecam.c
>   create mode 100644 drivers/pci/ecam.h
>
[...]
