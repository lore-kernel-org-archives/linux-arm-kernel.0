From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Jun 2017 14:02:36 +0800
Subject: [PATCH v2 2/3] PCI: Enable PCIe Relaxed Ordering if supported
In-Reply-To: <1496462647-7632-3-git-send-email-dingtianhong@huawei.com>
Message-ID: <201706031336.9FSK8cmm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ding,

[auto build test WARNING on pci/next]
[cannot apply to v4.12-rc3 next-20170602]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ding-Tianhong/Add-new-PCI_DEV_FLAGS_NO_RELAXED_ORDERING-flag/20170603-132448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: x86_64-randconfig-x019-201722 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

>> drivers//pci/pci.c:4922:1: warning: "/*" within comment [-Wcomment]
    /**
     

vim +4922 drivers//pci/pci.c

  4906	 * @dev: PCI device to query
  4907	 *
  4908	 * Returns true if relaxed ordering is been set
  4909	 */
  4910	int pcie_get_relaxed_ordering(struct pci_dev *dev)
  4911	{
  4912		u16 v;
  4913	
  4914		pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &v);
  4915	
  4916		return (v & PCI_EXP_DEVCTL_RELAX_EN) >> 4;
  4917	}
  4918	EXPORT_SYMBOL(pcie_get_relaxed_ordering);
  4919	
  4920	/**
  4921	 * pcie_set_mps - set PCI Express maximum payload size
> 4922	/**
  4923	 * pcie_get_minimum_link - determine minimum link settings of a PCI device
  4924	 * @dev: PCI device to query
  4925	 * @speed: storage for minimum speed
  4926	 * @width: storage for minimum width
  4927	 *
  4928	 * This function will walk up the PCI device chain and determine the minimum
  4929	 * link width and speed of the device.
  4930	 */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23461 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170603/40d2ad68/attachment-0001.gz>
