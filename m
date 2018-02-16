From: lkp@intel.com (kbuild test robot)
Date: Sat, 17 Feb 2018 00:22:32 +0800
Subject: [PATCH] arm64: acpi,efi: fix alignment fault in accessing ACPI
 tables at kdump
In-Reply-To: <20180201090449.19514-1-takahiro.akashi@linaro.org>
References: <20180201090449.19514-1-takahiro.akashi@linaro.org>
Message-ID: <201802170034.BMcAEki2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi AKASHI,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.16-rc1 next-20180216]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/AKASHI-Takahiro/arm64-acpi-efi-fix-alignment-fault-in-accessing-ACPI-tables-at-kdump/20180203-174725
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kernel/acpi.o: In function `__acpi_get_mem_attribute':
>> acpi.c:(.text+0x60): undefined reference to `efi_mem_attributes'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58514 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180217/5ce7c145/attachment-0001.gz>
