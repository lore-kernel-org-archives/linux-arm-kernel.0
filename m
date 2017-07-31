From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 31 Jul 2017 17:55:02 +0800
Subject: [xlnx:master 841/864] debug.c:(.text+0xa): multiple definition of
 `dwc3_set_simple_data'
Message-ID: <201707311758.tX5y2j6r%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   00346d2eba7634f4fb2c2117ac371e0c104a2870
commit: a4769f84c50a769e655d4bb9c1a8a45586cdc1f4 [841/864] dwc3: Add support for removing vbus when suspended
config: i386-randconfig-a1-07302228 (attached as .config)
compiler: gcc-5 (Debian 5.4.1-2) 5.4.1 20160904
reproduce:
        git checkout a4769f84c50a769e655d4bb9c1a8a45586cdc1f4
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/debug.o: In function `dwc3_simple_wakeup_capable':
   debug.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x698): first defined here
   drivers/usb/dwc3/debug.o: In function `dwc3_set_simple_data':
>> debug.c:(.text+0xa): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x6a2): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_simple_wakeup_capable':
   trace.c:(.text+0xd42): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x698): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_set_simple_data':
   trace.c:(.text+0xd4c): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x6a2): first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_simple_wakeup_capable':
   host.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x698): first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_set_simple_data':
   host.c:(.text+0xa): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x6a2): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_wakeup_capable':
   debugfs.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x698): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_set_simple_data':
   debugfs.c:(.text+0xa): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x6a2): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 25458 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/c87396e3/attachment-0001.gz>
