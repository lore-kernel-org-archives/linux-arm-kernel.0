From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 19 Sep 2017 04:11:49 +0800
Subject: [xlnx:master 841/1027] debug.c:(.text+0x10): multiple definition of
 `dwc3_set_simple_data'
Message-ID: <201709190446.sYkAQmR1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anurag,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   f9658a41c361182381160edbcea3c1de3b76dc9d
commit: a4769f84c50a769e655d4bb9c1a8a45586cdc1f4 [841/1027] dwc3: Add support for removing vbus when suspended
config: x86_64-rhel (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout a4769f84c50a769e655d4bb9c1a8a45586cdc1f4
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/debug.o: In function `dwc3_simple_wakeup_capable':
   debug.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x520): first defined here
   drivers/usb/dwc3/debug.o: In function `dwc3_set_simple_data':
>> debug.c:(.text+0x10): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x530): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_simple_wakeup_capable':
   trace.c:(.text+0x1880): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x520): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_set_simple_data':
   trace.c:(.text+0x1890): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x530): first defined here
   drivers/usb/dwc3/gadget.o: In function `dwc3_simple_wakeup_capable':
   gadget.c:(.text+0x10b0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x520): first defined here
   drivers/usb/dwc3/gadget.o: In function `dwc3_set_simple_data':
   gadget.c:(.text+0x10c0): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x530): first defined here
   drivers/usb/dwc3/ep0.o: In function `dwc3_simple_wakeup_capable':
   ep0.c:(.text+0xa10): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x520): first defined here
   drivers/usb/dwc3/ep0.o: In function `dwc3_set_simple_data':
   ep0.c:(.text+0xa20): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x530): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_wakeup_capable':
   debugfs.c:(.text+0xd40): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x520): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_set_simple_data':
   debugfs.c:(.text+0xd50): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x530): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38234 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170919/18943ceb/attachment-0001.gz>
