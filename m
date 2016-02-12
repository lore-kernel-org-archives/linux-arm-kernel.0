From: lkp@intel.com (kbuild test robot)
Date: Sat, 13 Feb 2016 02:44:16 +0800
Subject: [PATCH v2 3/9] ACPI: introduce acpi_table_parse2()
In-Reply-To: <1455299022-11641-4-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <201602130210.rOqbMzRs%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aleksey,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.5-rc3 next-20160212]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Aleksey-Makarov/ACPI-parse-the-SPCR-table/20160213-015350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-tinyconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86/kernel/i8259.o: In function `acpi_table_parse2':
>> i8259.c:(.text+0x2c4): multiple definition of `acpi_table_parse2'
   arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   arch/x86/kernel/irqinit.o: In function `acpi_table_parse2':
   irqinit.c:(.text+0x0): multiple definition of `acpi_table_parse2'
   arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   arch/x86/kernel/bootflag.o: In function `acpi_table_parse2':
   bootflag.c:(.text+0x0): multiple definition of `acpi_table_parse2'
   arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   arch/x86/kernel/e820.o: In function `acpi_table_parse2':
   e820.c:(.text+0x0): multiple definition of `acpi_table_parse2'
   arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   arch/x86/kernel/pci-dma.o: In function `acpi_table_parse2':
   pci-dma.c:(.text+0x0): multiple definition of `acpi_table_parse2'
   arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here
   arch/x86/kernel/rtc.o: In function `acpi_table_parse2':
   rtc.c:(.text+0x43): multiple definition of `acpi_table_parse2'
   arch/x86/kernel/setup.o:setup.c:(.text+0x3): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 6205 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160213/0cb21c2c/attachment-0001.obj>
