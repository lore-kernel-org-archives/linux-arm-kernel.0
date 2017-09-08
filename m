From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 8 Sep 2017 19:47:09 +0800
Subject: [xlnx:master 869/1008] debug.c:(.text+0x20): multiple definition of
 `dwc3_simple_check_quirks'
Message-ID: <201709081905.UE3anAOI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anurag,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   fec1fe44076b1b2f8b7d6b2669697ea16b33a215
commit: 244ddcbd8d1c0bc8df49172e973f0384abf7fe9f [869/1008] dwc3: Correct errors when dwc3 loaded as module
config: i386-randconfig-s0-201736 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 244ddcbd8d1c0bc8df49172e973f0384abf7fe9f
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/debug.o: In function `dwc3_simple_wakeup_capable':
   debug.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x410): first defined here
   drivers/usb/dwc3/debug.o: In function `dwc3_set_simple_data':
   debug.c:(.text+0x10): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x420): first defined here
   drivers/usb/dwc3/debug.o: In function `dwc3_simple_check_quirks':
>> debug.c:(.text+0x20): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x430): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_simple_wakeup_capable':
   trace.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x410): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_set_simple_data':
   trace.c:(.text+0x10): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x420): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_simple_check_quirks':
   trace.c:(.text+0x20): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x430): first defined here
   drivers/usb/dwc3/gadget.o: In function `dwc3_simple_wakeup_capable':
   gadget.c:(.text+0xd20): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x410): first defined here
   drivers/usb/dwc3/gadget.o: In function `dwc3_set_simple_data':
   gadget.c:(.text+0xd30): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x420): first defined here
   drivers/usb/dwc3/gadget.o: In function `dwc3_simple_check_quirks':
   gadget.c:(.text+0xd40): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x430): first defined here
   drivers/usb/dwc3/ep0.o: In function `dwc3_simple_wakeup_capable':
   ep0.c:(.text+0x940): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x410): first defined here
   drivers/usb/dwc3/ep0.o: In function `dwc3_set_simple_data':
   ep0.c:(.text+0x950): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x420): first defined here
   drivers/usb/dwc3/ep0.o: In function `dwc3_simple_check_quirks':
   ep0.c:(.text+0x960): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x430): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_wakeup_capable':
   debugfs.c:(.text+0xc70): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x410): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_set_simple_data':
   debugfs.c:(.text+0xc80): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x420): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_check_quirks':
   debugfs.c:(.text+0xc90): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x430): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29669 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170908/cba3488c/attachment-0001.gz>
