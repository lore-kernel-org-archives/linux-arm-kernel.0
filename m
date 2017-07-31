From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 31 Jul 2017 16:58:34 +0800
Subject: [xlnx:master 823/864] debug.c:(.text+0x0): multiple definition of
 `dwc3_simple_wakeup_capable'
Message-ID: <201707311628.ztq8DZnm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   00346d2eba7634f4fb2c2117ac371e0c104a2870
commit: 80ac0da9010ebabef6ed1d66b6607b345fd14cb4 [823/864] dwc3: Add support for clock disabling during suspend
config: i386-randconfig-a1-07302228 (attached as .config)
compiler: gcc-5 (Debian 5.4.1-2) 5.4.1 20160904
reproduce:
        git checkout 80ac0da9010ebabef6ed1d66b6607b345fd14cb4
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/debug.o: In function `dwc3_simple_wakeup_capable':
>> debug.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x698): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_simple_wakeup_capable':
   trace.c:(.text+0xd42): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x698): first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_simple_wakeup_capable':
   host.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x698): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_wakeup_capable':
   debugfs.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x698): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25458 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/c955b215/attachment-0001.gz>
