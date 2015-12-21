From: lkp@intel.com (kbuild test robot)
Date: Tue, 22 Dec 2015 00:28:15 +0800
Subject: [PATCH v2 1/3] ACPI: amba bus probing support
In-Reply-To: <1450709399-7246-2-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <201512220040.gNdKEc5p%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Graeme,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.4-rc6 next-20151221]

url:    https://github.com/0day-ci/linux/commits/Aleksey-Makarov/ACPI-amba-bus-probing-support/20151221-225448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-s1-201551 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/acpi/utils.o: In function `acpi_amba_init':
>> utils.c:(.text+0x39): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/nvs.o: In function `acpi_amba_init':
   nvs.c:(.text+0x0): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/wakeup.o: In function `acpi_amba_init':
   wakeup.c:(.text+0x0): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/sleep.o: In function `acpi_amba_init':
   sleep.c:(.text+0x89): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/device_sysfs.o: In function `acpi_amba_init':
   device_sysfs.c:(.text+0x584): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/device_pm.o: In function `acpi_amba_init':
   device_pm.c:(.text+0x1ed): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/bus.o: In function `acpi_amba_init':
   bus.c:(.text+0x514): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/glue.o: In function `acpi_amba_init':
   glue.c:(.text+0xd3): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/scan.o: In function `acpi_amba_init':
   scan.c:(.text+0x1f1): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/acpi_processor.o: In function `acpi_amba_init':
   acpi_processor.c:(.text+0x39a): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/processor_pdc.o: In function `acpi_amba_init':
   processor_pdc.c:(.text+0x0): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/ec.o: In function `acpi_amba_init':
   ec.c:(.text+0x15ad): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/pci_root.o: In function `acpi_amba_init':
   pci_root.c:(.text+0x689): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/pci_link.o: In function `acpi_amba_init':
   pci_link.c:(.text+0x5c4): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/acpi_lpss.o: In function `acpi_amba_init':
   acpi_lpss.c:(.text+0x0): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/acpi_apd.o: In function `acpi_amba_init':
   acpi_apd.c:(.text+0x8d): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/acpi_platform.o: In function `acpi_amba_init':
   acpi_platform.c:(.text+0x0): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/int340x_thermal.o: In function `acpi_amba_init':
   int340x_thermal.c:(.text+0x1b): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/power.o: In function `acpi_amba_init':
   power.c:(.text+0x2c5): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/event.o: In function `acpi_amba_init':
   event.c:(.text+0x0): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/sysfs.o: In function `acpi_amba_init':
   sysfs.c:(.text+0x623): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/property.o: In function `acpi_amba_init':
   property.c:(.text+0x618): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/acpi_cmos_rtc.o: In function `acpi_amba_init':
   acpi_cmos_rtc.c:(.text+0xde): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here
   drivers/acpi/debugfs.o: In function `acpi_amba_init':
   debugfs.c:(.text+0x0): multiple definition of `acpi_amba_init'
   drivers/acpi/osl.o:osl.c:(.text+0x176): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22084 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151222/9566c633/attachment-0001.obj>
