From: lkp@intel.com (kbuild test robot)
Date: Wed, 9 Dec 2015 05:04:38 +0800
Subject: [PATCH v4 1/5] acpi: pci: Setup MSI domain for ACPI based pci
 devices
In-Reply-To: <1449605945-10707-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <201512090536.i9Nf2RVq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suravee,

[auto build test ERROR on tip/irq/core]
[also build test ERROR on v4.4-rc4 next-20151208]

url:    https://github.com/0day-ci/linux/commits/Suravee-Suthikulpanit/gicv2m-acpi-Add-ACPI-support-for-GICv2m-MSI/20151209-042217
config: i386-alldefconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/pci/pci-acpi.c: In function 'pci_host_bridge_acpi_msi_domain':
>> drivers/pci/pci-acpi.c:719:9: error: implicit declaration of function 'irq_find_matching_fwnode' [-Werror=implicit-function-declaration]
      dom = irq_find_matching_fwnode(fwnode,
            ^
>> drivers/pci/pci-acpi.c:719:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      dom = irq_find_matching_fwnode(fwnode,
          ^
   cc1: some warnings being treated as errors

vim +/irq_find_matching_fwnode +719 drivers/pci/pci-acpi.c

   713		struct fwnode_handle *fwnode = NULL;
   714	
   715		if (pci_msi_get_fwnode_cb)
   716			fwnode = pci_msi_get_fwnode_cb(&bus->dev);
   717	
   718		if (fwnode)
 > 719			dom = irq_find_matching_fwnode(fwnode,
   720						       DOMAIN_BUS_PCI_MSI);
   721		return dom;
   722	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 9560 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151209/8ed3c71c/attachment.obj>
