From: lkp@intel.com (kbuild test robot)
Date: Sat, 11 Jun 2016 15:09:49 +0800
Subject: [PATCH v2 2/3] PCI: host: new PCI host controller driver for
 Aardvark
In-Reply-To: <1465574056-8787-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201606111501.h2bC6u5a%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on pci/next]
[also build test ERROR on v4.7-rc2 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Thomas-Petazzoni/Aardvark-PCIe-controller-driver-for-Marvell-Armada-3700/20160611-001044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: x86_64-lkp (attached as .config)
compiler: gcc-4.9 (Debian 4.9.3-14) 4.9.3
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> drivers/of/Kconfig:4:error: recursive dependency detected!
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   drivers/of/Kconfig:4:	symbol OF is selected by X86_INTEL_CE
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   arch/x86/Kconfig:501:	symbol X86_INTEL_CE depends on X86_IO_APIC
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   arch/x86/Kconfig:970:	symbol X86_IO_APIC depends on X86_LOCAL_APIC
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   arch/x86/Kconfig:964:	symbol X86_LOCAL_APIC depends on X86_UP_APIC
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   arch/x86/Kconfig:939:	symbol X86_UP_APIC depends on PCI_MSI
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   drivers/pci/Kconfig:11:	symbol PCI_MSI is selected by PCI_AARDVARK
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   drivers/pci/host/Kconfig:19:	symbol PCI_AARDVARK depends on OF
--
>> drivers/of/Kconfig:4:error: recursive dependency detected!
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   drivers/of/Kconfig:4:	symbol OF is selected by X86_INTEL_CE
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   arch/x86/Kconfig:501:	symbol X86_INTEL_CE depends on X86_IO_APIC
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   arch/x86/Kconfig:970:	symbol X86_IO_APIC depends on X86_LOCAL_APIC
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   arch/x86/Kconfig:964:	symbol X86_LOCAL_APIC depends on X86_UP_APIC
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   arch/x86/Kconfig:939:	symbol X86_UP_APIC depends on PCI_MSI
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   drivers/pci/Kconfig:11:	symbol PCI_MSI is selected by PCI_AARDVARK
   For a resolution refer to Documentation/kbuild/kconfig-language.txt
   subsection "Kconfig recursive dependency limitations"
   drivers/pci/host/Kconfig:19:	symbol PCI_AARDVARK depends on OF
   .config:429:warning: symbol value 'm' invalid for MICROCODE
   .config:2991:warning: symbol value 'm' invalid for FAULT_INJECTION

vim +4 drivers/of/Kconfig

5ab5fc7e Grant Likely     2010-07-05   1  config DTC
5ab5fc7e Grant Likely     2010-07-05   2  	bool
5ab5fc7e Grant Likely     2010-07-05   3  
0166dc11 Rob Herring      2015-05-28  @4  menuconfig OF
0166dc11 Rob Herring      2015-05-28   5  	bool "Device Tree and Open Firmware support"
0166dc11 Rob Herring      2015-05-28   6  	help
0166dc11 Rob Herring      2015-05-28   7  	  This option enables the device tree infrastructure.
0166dc11 Rob Herring      2015-05-28   8  	  It is automatically selected by platforms that need it or can
0166dc11 Rob Herring      2015-05-28   9  	  be enabled manually for unittests, overlays or
0166dc11 Rob Herring      2015-05-28  10  	  compile-coverage.
bcbefae2 Stephen Rothwell 2010-06-29  11  
0166dc11 Rob Herring      2015-05-28  12  if OF

:::::: The code at line 4 was first introduced by commit
:::::: 0166dc11be911213e0b1b764488c671be4c48cf3 of: make CONFIG_OF user selectable

:::::: TO: Rob Herring <robh@kernel.org>
:::::: CC: Rob Herring <robh@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23365 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160611/be0a7e9e/attachment-0001.obj>
