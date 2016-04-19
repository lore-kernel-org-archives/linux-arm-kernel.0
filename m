From: lkp@intel.com (kbuild test robot)
Date: Tue, 19 Apr 2016 21:59:37 +0800
Subject: [PATCH v4 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <1461069013-13292-5-git-send-email-sudeep.holla@arm.com>
Message-ID: <201604192134.oK2yB12J%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.6-rc4 next-20160419]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Sudeep-Holla/ACPI-processor_idle-Add-ACPI-v6-0-LPI-support/20160419-203500
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm-sunxi_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from drivers/firmware/psci.c:36:0:
>> include/acpi/processor.h:7:22: fatal error: asm/acpi.h: No such file or directory
    #include <asm/acpi.h>
                         ^
   compilation terminated.

vim +7 include/acpi/processor.h

^1da177e4c Linus Torvalds      2005-04-16   1  #ifndef __ACPI_PROCESSOR_H
^1da177e4c Linus Torvalds      2005-04-16   2  #define __ACPI_PROCESSOR_H
^1da177e4c Linus Torvalds      2005-04-16   3  
^1da177e4c Linus Torvalds      2005-04-16   4  #include <linux/kernel.h>
3b2d99429e Venkatesh Pallipadi 2005-12-14   5  #include <linux/cpu.h>
d9460fd227 Zhang Rui           2008-01-17   6  #include <linux/thermal.h>
02df8b9385 Venkatesh Pallipadi 2005-04-15  @7  #include <asm/acpi.h>
02df8b9385 Venkatesh Pallipadi 2005-04-15   8  
ac212b6980 Rafael J. Wysocki   2013-05-03   9  #define ACPI_PROCESSOR_CLASS		"processor"
ac212b6980 Rafael J. Wysocki   2013-05-03  10  #define ACPI_PROCESSOR_DEVICE_NAME	"Processor"

:::::: The code at line 7 was first introduced by commit
:::::: 02df8b9385c21fdba165bd380f60eca1d3b0578b [ACPI] enable C2 and C3 idle power states on SMP http://bugzilla.kernel.org/show_bug.cgi?id=4401

:::::: TO: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
:::::: CC: Len Brown <len.brown@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 19252 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160419/2cd19c9d/attachment-0001.obj>
