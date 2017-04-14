From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 14 Apr 2017 15:10:38 -0400
Subject: [PATCH V8 1/5] PCI/ASPM: introduce pci_aspm_init() and add to
 pci_init_capabilities()
In-Reply-To: <20170413205125.GC28316@bhelgaas-glaptop.roam.corp.google.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-2-git-send-email-okaya@codeaurora.org>
 <20170413205125.GC28316@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <f6e9637d-8c5e-3363-d448-b910ca53e046@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2017 4:51 PM, Bjorn Helgaas wrote:
> I think these can go in drivers/pci/pci.h instead of the public
> include/linux/pci.h.  There's no ASPM section in drivers/pci/pci.h
> yet, but I think we should add one.
> 
> It looks like the following things from include/linux/pci-aspm.h could
> be moved there as well, since they're only used by the PCI core:
> 
>   void pcie_aspm_init_link_state(struct pci_dev *pdev);
>   void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>   void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>   void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
>   void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
> 
> This would be a separate patch.
> 

Sure, let me work on this.

>>  #else
>>  static inline bool pcie_aspm_support_enabled(void) { return false; }
>> +static inline int pci_aspm_init(struct pci_dev *pdev) { return -ENODEV; }
>>  #endif


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
