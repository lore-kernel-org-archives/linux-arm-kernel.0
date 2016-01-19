From: lkp@intel.com (kbuild test robot)
Date: Wed, 20 Jan 2016 02:26:15 +0800
Subject: [PATCH V3 10/10] acpi, gicv3, its: Use MADT ITS subtable to do
 PCI/MSI domain initialization.
In-Reply-To: <1453209083-3358-11-git-send-email-tn@semihalf.com>
Message-ID: <201601200231.5eyNsiQb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

[auto build test ERROR on v4.4-rc8]
[cannot apply to tip/irq/core next-20160119]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Tomasz-Nowicki/Introduce-ACPI-world-to-GICv3-ITS-irqchip/20160119-211652
config: arm64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3-its-pci-msi.c: In function 'its_pci_msi_parse_madt':
>> drivers/irqchip/irq-gic-v3-its-pci-msi.c:168:2: error: implicit declaration of function 'pci_msi_register_fwnode_provider' [-Werror=implicit-function-declaration]
     pci_msi_register_fwnode_provider(&iort_find_pci_domain_token);
     ^
   cc1: some warnings being treated as errors

vim +/pci_msi_register_fwnode_provider +168 drivers/irqchip/irq-gic-v3-its-pci-msi.c

   162			return 0;
   163		}
   164	
   165		if (its_pci_msi_init_one(domain_handle))
   166			return 0;
   167	
 > 168		pci_msi_register_fwnode_provider(&iort_find_pci_domain_token);
   169		pr_info("PCI/MSI: ITS at 0x%lx domain created\n",
   170			(long)its_entry->base_address);
   171		return 0;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46675 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160120/7b83b434/attachment-0001.obj>
