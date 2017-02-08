From: lkp@intel.com (kbuild test robot)
Date: Wed, 8 Feb 2017 08:12:59 +0800
Subject: [PATCH v4 2/3] PCI: imx6: Allow probe deferal by reset GPIO
In-Reply-To: <20170207155027.7734-3-andrew.smirnov@gmail.com>
Message-ID: <201702080824.vUnggnsd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.10-rc7 next-20170207]
[cannot apply to pci/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Andrey-Smirnov/PCI-imx6-Fix-a-typo-in-error-message/20170208-014815
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.text+0x4d99fc): Section mismatch in reference from the function imx6_pcie_probe() to the function .init.text:hook_fault_code()
   The function imx6_pcie_probe() references
   the function __init hook_fault_code().
   This is often because imx6_pcie_probe lacks a __init
   annotation or the annotation of hook_fault_code is wrong.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60380 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170208/4de16b82/attachment-0001.gz>
