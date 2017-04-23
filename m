From: lkp@intel.com (kbuild test robot)
Date: Sun, 23 Apr 2017 18:31:06 +0800
Subject: [PATCH 1/2] PCI: mediatek: Add Mediatek PCIe host controller
 support
In-Reply-To: <1492935543-18190-2-git-send-email-ryder.lee@mediatek.com>
Message-ID: <201704231826.aSxlgvd0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryder,

[auto build test WARNING on pci/next]
[also build test WARNING on v4.11-rc7 next-20170421]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ryder-Lee/Add-PCIe-host-driver-support-for-some-Mediatek-SoCs/20170423-163432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All warnings (new ones prefixed by >>):

>> WARNING: drivers/pci/host/built-in.o(.text+0x1830): Section mismatch in reference from the function mtk_pcie_probe() to the function .init.text:mtk_pcie_map_irq()
   The function mtk_pcie_probe() references
   the function __init mtk_pcie_map_irq().
   This is often because mtk_pcie_probe lacks a __init
   annotation or the annotation of mtk_pcie_map_irq is wrong.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170423/3ce975ba/attachment-0001.gz>
