From: lkp@intel.com (kbuild test robot)
Date: Wed, 7 Sep 2016 23:21:28 +0800
Subject: [PATCH V2 1/4] ARM64 LPC: Indirect ISA port IO introduced
In-Reply-To: <1473255233-154297-2-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201609072347.2zPqLYFF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc5 next-20160907]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Zhichang-Yuan/ARM64-LPC-legacy-ISA-I-O-support/20160907-212837
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   drivers/of/address.c: In function '__of_address_to_resource':
>> drivers/of/address.c:691:2: error: implicit declaration of function 'of_bus_pci_match'

vim +/of_bus_pci_match +691 drivers/of/address.c

   685		if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
   686			return -EINVAL;
   687		taddr = of_translate_address(dev, addrp);
   688		if (taddr == OF_BAD_ADDR)
   689			return -EINVAL;
   690		memset(r, 0, sizeof(struct resource));
 > 691		if (flags & IORESOURCE_IO && of_bus_pci_match(dev)) {
   692			unsigned long port;
   693	
   694			port = pci_address_to_pio(taddr);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 7194 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/9b986b21/attachment-0001.obj>
