From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 10 Aug 2017 20:08:40 +0800
Subject: [xlnx:master 869/880] debug.c:(.text+0x20): multiple definition of
 `dwc3_simple_check_quirks'
Message-ID: <201708102038.le13wD04%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   e51604bf16d3aaf13ace953eb434359ba9247a91
commit: 244ddcbd8d1c0bc8df49172e973f0384abf7fe9f [869/880] dwc3: Correct errors when dwc3 loaded as module
config: x86_64-rhel (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 244ddcbd8d1c0bc8df49172e973f0384abf7fe9f
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/debug.o: In function `dwc3_simple_wakeup_capable':
   debug.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x520): first defined here
   drivers/usb/dwc3/debug.o: In function `dwc3_set_simple_data':
   debug.c:(.text+0x10): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x530): first defined here
   drivers/usb/dwc3/debug.o: In function `dwc3_simple_check_quirks':
>> debug.c:(.text+0x20): multiple definition of `dwc3_simple_check_quirks'
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170810/23e71913/attachment-0001.gz>
