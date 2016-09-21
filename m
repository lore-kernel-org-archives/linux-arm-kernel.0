From: lkp@intel.com (kbuild test robot)
Date: Thu, 22 Sep 2016 01:14:32 +0800
Subject: [PATCH] usb: xhci: Fix the patch inherit dma configuration from
In-Reply-To: <DB5PR0401MB1925CDF6CBD45ACBEE95D152F5F60@DB5PR0401MB1925.eurprd04.prod.outlook.com>
Message-ID: <201609220122.CBgu9ja6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sriram,

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on v4.8-rc7 next-20160921]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Sriram-Dash/usb-xhci-Fix-the-patch-inherit-dma-configuration-from/20160922-004329
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: x86_64-randconfig-x012-201638 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/list.h:8:0,
                    from include/linux/pci.h:25,
                    from drivers/usb/host/xhci.c:23:
   drivers/usb/host/xhci.c: In function 'xhci_setup_msi':
>> drivers/usb/host/xhci.c:234:60: error: 'struct usb_bus' has no member named 'sysdev'
     struct pci_dev  *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.sysdev);
                                                               ^
   include/linux/kernel.h:831:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^~~
>> drivers/usb/host/xhci.c:234:26: note: in expansion of macro 'to_pci_dev'
     struct pci_dev  *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.sysdev);
                             ^~~~~~~~~~
   drivers/usb/host/xhci.c: In function 'xhci_free_irq':
   drivers/usb/host/xhci.c:260:59: error: 'struct usb_bus' has no member named 'sysdev'
     struct pci_dev *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.sysdev);
                                                              ^
   include/linux/kernel.h:831:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^~~
   drivers/usb/host/xhci.c:260:25: note: in expansion of macro 'to_pci_dev'
     struct pci_dev *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.sysdev);
                            ^~~~~~~~~~
   drivers/usb/host/xhci.c: In function 'xhci_setup_msix':
   drivers/usb/host/xhci.c:283:45: error: 'struct usb_bus' has no member named 'sysdev'
     struct pci_dev *pdev = to_pci_dev(hcd->self.sysdev);
                                                ^
   include/linux/kernel.h:831:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^~~
   drivers/usb/host/xhci.c:283:25: note: in expansion of macro 'to_pci_dev'
     struct pci_dev *pdev = to_pci_dev(hcd->self.sysdev);
                            ^~~~~~~~~~
   drivers/usb/host/xhci.c: In function 'xhci_cleanup_msix':
   drivers/usb/host/xhci.c:338:45: error: 'struct usb_bus' has no member named 'sysdev'
     struct pci_dev *pdev = to_pci_dev(hcd->self.sysdev);
                                                ^
   include/linux/kernel.h:831:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^~~
   drivers/usb/host/xhci.c:338:25: note: in expansion of macro 'to_pci_dev'
     struct pci_dev *pdev = to_pci_dev(hcd->self.sysdev);
                            ^~~~~~~~~~
   drivers/usb/host/xhci.c: In function 'xhci_try_enable_msi':
   drivers/usb/host/xhci.c:377:43: error: 'struct usb_bus' has no member named 'sysdev'
     pdev = to_pci_dev(xhci_to_hcd(xhci)->self.sysdev);
                                              ^
   include/linux/kernel.h:831:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^~~
   drivers/usb/host/xhci.c:377:9: note: in expansion of macro 'to_pci_dev'
     pdev = to_pci_dev(xhci_to_hcd(xhci)->self.sysdev);
            ^~~~~~~~~~
   drivers/usb/host/xhci.c: In function 'xhci_shutdown':
   drivers/usb/host/xhci.c:746:46: error: 'struct usb_bus' has no member named 'sysdev'
      usb_disable_xhci_ports(to_pci_dev(hcd->self.sysdev));
                                                 ^
   include/linux/kernel.h:831:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^~~
   drivers/usb/host/xhci.c:746:26: note: in expansion of macro 'to_pci_dev'
      usb_disable_xhci_ports(to_pci_dev(hcd->self.sysdev));
                             ^~~~~~~~~~
   drivers/usb/host/xhci.c:763:43: error: 'struct usb_bus' has no member named 'sysdev'
      pci_set_power_state(to_pci_dev(hcd->self.sysdev), PCI_D3hot);
                                              ^
   include/linux/kernel.h:831:49: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                    ^~~
   drivers/usb/host/xhci.c:763:23: note: in expansion of macro 'to_pci_dev'
      pci_set_power_state(to_pci_dev(hcd->self.sysdev), PCI_D3hot);
                          ^~~~~~~~~~
   drivers/usb/host/xhci.c: In function 'xhci_gen_setup':
   drivers/usb/host/xhci.c:4835:33: error: 'struct usb_bus' has no member named 'sysdev'
     struct device  *dev = hcd->self.sysdev;
                                    ^
--
   drivers/usb/host/xhci-mem.c: In function 'xhci_free_stream_ctx':
>> drivers/usb/host/xhci-mem.c:589:46: error: 'struct usb_bus' has no member named 'sysdev'
     struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
                                                 ^
   drivers/usb/host/xhci-mem.c: In function 'xhci_alloc_stream_ctx':
   drivers/usb/host/xhci-mem.c:617:46: error: 'struct usb_bus' has no member named 'sysdev'
     struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
                                                 ^
   drivers/usb/host/xhci-mem.c: In function 'scratchpad_alloc':
   drivers/usb/host/xhci-mem.c:1647:46: error: 'struct usb_bus' has no member named 'sysdev'
     struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
                                                 ^
   drivers/usb/host/xhci-mem.c: In function 'scratchpad_free':
   drivers/usb/host/xhci-mem.c:1719:46: error: 'struct usb_bus' has no member named 'sysdev'
     struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
                                                 ^
   drivers/usb/host/xhci-mem.c: In function 'xhci_mem_cleanup':
   drivers/usb/host/xhci-mem.c:1795:46: error: 'struct usb_bus' has no member named 'sysdev'
     struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
                                                 ^
   drivers/usb/host/xhci-mem.c: In function 'xhci_mem_init':
   drivers/usb/host/xhci-mem.c:2337:46: error: 'struct usb_bus' has no member named 'sysdev'
     struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
                                                 ^

vim +234 drivers/usb/host/xhci.c

   228	/*
   229	 * Set up MSI
   230	 */
   231	static int xhci_setup_msi(struct xhci_hcd *xhci)
   232	{
   233		int ret;
 > 234		struct pci_dev  *pdev = to_pci_dev(xhci_to_hcd(xhci)->self.sysdev);
   235	
   236		ret = pci_enable_msi(pdev);
   237		if (ret) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21706 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160922/df321917/attachment-0001.gz>
