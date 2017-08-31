From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 1 Sep 2017 05:15:51 +0800
Subject: [xlnx:master 876/1001] debug.c:(.text+0x10): multiple definition of
 `dwc3_set_simple_data'
Message-ID: <201709010549.gXpkCSaX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   9f16845d5da076e11c8b94a0ca8cf944a62a24fb
commit: 6b3aa1785e4630ec15fd2f25fc7a8e4b00b19924 [876/1001] net: phy: xilinx_phy: Add support for 2p5G phy
config: x86_64-rhel (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 6b3aa1785e4630ec15fd2f25fc7a8e4b00b19924
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/debug.o: In function `dwc3_simple_wakeup_capable':
   debug.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x520): first defined here
   drivers/usb/dwc3/debug.o: In function `dwc3_set_simple_data':
>> debug.c:(.text+0x10): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x530): first defined here
   drivers/usb/dwc3/debug.o: In function `dwc3_simple_check_quirks':
   debug.c:(.text+0x20): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x540): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_simple_wakeup_capable':
   trace.c:(.text+0x1880): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x520): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_set_simple_data':
   trace.c:(.text+0x1890): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x530): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_simple_check_quirks':
   trace.c:(.text+0x18a0): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x540): first defined here
   drivers/usb/dwc3/gadget.o: In function `dwc3_simple_wakeup_capable':
   gadget.c:(.text+0x10b0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x520): first defined here
   drivers/usb/dwc3/gadget.o: In function `dwc3_set_simple_data':
   gadget.c:(.text+0x10c0): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x530): first defined here
   drivers/usb/dwc3/gadget.o: In function `dwc3_simple_check_quirks':
   gadget.c:(.text+0x10d0): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x540): first defined here
   drivers/usb/dwc3/ep0.o: In function `dwc3_simple_wakeup_capable':
   ep0.c:(.text+0xa10): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x520): first defined here
   drivers/usb/dwc3/ep0.o: In function `dwc3_set_simple_data':
   ep0.c:(.text+0xa20): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x530): first defined here
   drivers/usb/dwc3/ep0.o: In function `dwc3_simple_check_quirks':
   ep0.c:(.text+0xa30): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x540): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_wakeup_capable':
   debugfs.c:(.text+0xd40): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x520): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_set_simple_data':
   debugfs.c:(.text+0xd50): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x530): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_check_quirks':
   debugfs.c:(.text+0xd60): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x540): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38073 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170901/06d492d9/attachment-0001.gz>
