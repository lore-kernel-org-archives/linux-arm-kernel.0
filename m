From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 2 Oct 2015 22:01:34 +0800
Subject: [arm-platforms:irq/msi-map-pci 12/13] drivers/pci/probe.c:1646:6:
 error: implicit declaration of function 'pci_msi_get_device_domain'
Message-ID: <201510022232.mLdqVPIt%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/msi-map-pci
head:   1ab5975873b783abe6d2f748f54ca5bef44b183f
commit: 927ae5900fd916fe63de4cba2f1c6c3f61d10806 [12/13] PCI/MSI: Allow the MSI domain to be device-specific
config: i386-randconfig-a0-201539 (attached as .config)
reproduce:
        git checkout 927ae5900fd916fe63de4cba2f1c6c3f61d10806
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/pci/probe.c: In function 'pci_dev_msi_domain':
>> drivers/pci/probe.c:1646:6: error: implicit declaration of function 'pci_msi_get_device_domain' [-Werror=implicit-function-declaration]
     d = pci_msi_get_device_domain(dev);
         ^
   drivers/pci/probe.c:1646:4: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     d = pci_msi_get_device_domain(dev);
       ^
   cc1: some warnings being treated as errors

vim +/pci_msi_get_device_domain +1646 drivers/pci/probe.c

  1640			return d;
  1641	
  1642		/*
  1643		 * Let's see if we have a firmware interface able to provide
  1644		 * the domain.
  1645		 */
> 1646		d = pci_msi_get_device_domain(dev);
  1647		if (d)
  1648			return d;
  1649	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 20807 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/2d8ae80c/attachment-0001.obj>
