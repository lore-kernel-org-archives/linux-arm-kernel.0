From: lkp@intel.com (kbuild test robot)
Date: Wed, 14 Sep 2016 22:09:58 +0800
Subject: [PATCH V3 2/4] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <1473855354-150093-3-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201609142255.GsgyGYrc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc6 next-20160914]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Zhichang-Yuan/ARM64-LPC-legacy-ISA-I-O-support/20160914-202858
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   drivers/of/address.c: In function '__of_address_to_resource':
>> drivers/of/address.c:702:5: error: implicit declaration of function 'of_bus_pci_match'

vim +/of_bus_pci_match +702 drivers/of/address.c

   696				return -EINVAL;
   697			/*
   698			 * special processing for non-pci device gurantee the linux start pio
   699			 * is not ZERO. Otherwise, some drivers' initialization will fail.
   700			 */
   701			if (!port && (!IS_ENABLED(CONFIG_OF_ADDRESS_PCI) ||
 > 702					!of_bus_pci_match(dev)))
   703				port += 1;
   704	
   705			r->start = port;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 7187 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160914/6b1ff665/attachment.obj>
