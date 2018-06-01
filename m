From: lkp@intel.com (kbuild test robot)
Date: Fri, 1 Jun 2018 08:42:27 +0800
Subject: [PATCH] PCI: mediatek: Add system pm support for MT2712
In-Reply-To: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
References: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <201806010727.GOthd5OK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Honghui,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on next-20180531]
[cannot apply to v4.17-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/honghui-zhang-mediatek-com/PCI-mediatek-Add-system-pm-support-for-MT2712/20180601-053217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/pci/host/pcie-mediatek.c:463:40: sparse: incorrect type in argument 1 (different address spaces) @@    expected void volatile *address @@    got void [novoid volatile *address @@
   drivers/pci/host/pcie-mediatek.c:463:40:    expected void volatile *address
   drivers/pci/host/pcie-mediatek.c:463:40:    got void [noderef] <asn:2>*
   drivers/pci/host/pcie-mediatek.c:586:44: sparse: incorrect type in argument 1 (different address spaces) @@    expected void volatile *address @@    got void [novoid volatile *address @@
   drivers/pci/host/pcie-mediatek.c:586:44:    expected void volatile *address
   drivers/pci/host/pcie-mediatek.c:586:44:    got void [noderef] <asn:2>*
>> drivers/pci/host/pcie-mediatek.c:1259:25: sparse: symbol 'mtk_pcie_pm_ops' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
