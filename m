From: lkp@intel.com (kbuild test robot)
Date: Tue, 21 Aug 2018 13:34:02 +0800
Subject: [PATCH] PCI: dwc: fix scheduling while atomic issues
In-Reply-To: <20180821104433.1c408d7e@xhacker.debian>
References: <20180821104433.1c408d7e@xhacker.debian>
Message-ID: <201808211313.002K85nJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

I love your patch! Yet something to improve:

[auto build test ERROR on pci/next]
[also build test ERROR on v4.18 next-20180820]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jisheng-Zhang/PCI-dwc-fix-scheduling-while-atomic-issues/20180821-110033
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-omap2plus_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware.o: In function `dw_pcie_prog_outbound_atu':
>> pcie-designware.c:(.text+0x32c): undefined reference to `__bad_udelay'
   pcie-designware.c:(.text+0x424): undefined reference to `__bad_udelay'
   drivers/pci/controller/dwc/pcie-designware.o: In function `dw_pcie_prog_inbound_atu':
   pcie-designware.c:(.text+0x538): undefined reference to `__bad_udelay'
   pcie-designware.c:(.text+0x608): undefined reference to `__bad_udelay'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33987 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180821/40ca266d/attachment-0001.gz>
