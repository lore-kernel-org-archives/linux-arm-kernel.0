From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 18 Oct 2017 01:07:48 +0800
Subject: [xlnx:master 1048/1054] debug.c:(.text+0xf): multiple definition of
 `dwc3_set_usb_core_power'
Message-ID: <201710180129.D7xNKR9O%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   e82bfab8e7e6978a3009461f661964f45712bfdb
commit: 4e93ddc6c0fad23387c55e185019e5091fb0b5ad [1048/1054] dwc3: Add code for supporting entering into D3 state during suspend
config: i386-randconfig-a0-201742 (attached as .config)
compiler: gcc-5 (Debian 5.4.1-2) 5.4.1 20160904
reproduce:
        git checkout 4e93ddc6c0fad23387c55e185019e5091fb0b5ad
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/usb/dwc3/debug.o: In function `dwc3_simple_wakeup_capable':
   debug.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x316): first defined here
   drivers/usb/dwc3/debug.o: In function `dwc3_set_simple_data':
   debug.c:(.text+0x5): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x31b): first defined here
   drivers/usb/dwc3/debug.o: In function `dwc3_simple_check_quirks':
   debug.c:(.text+0xa): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x320): first defined here
   drivers/usb/dwc3/debug.o: In function `dwc3_set_usb_core_power':
>> debug.c:(.text+0xf): multiple definition of `dwc3_set_usb_core_power'
   drivers/usb/dwc3/core.o:core.c:(.text+0x325): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_simple_wakeup_capable':
   trace.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x316): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_set_simple_data':
   trace.c:(.text+0x5): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x31b): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_simple_check_quirks':
   trace.c:(.text+0xa): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x320): first defined here
   drivers/usb/dwc3/trace.o: In function `dwc3_set_usb_core_power':
   trace.c:(.text+0xf): multiple definition of `dwc3_set_usb_core_power'
   drivers/usb/dwc3/core.o:core.c:(.text+0x325): first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_simple_wakeup_capable':
   host.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x316): first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_set_simple_data':
   host.c:(.text+0x5): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x31b): first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_simple_check_quirks':
   host.c:(.text+0xa): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x320): first defined here
   drivers/usb/dwc3/host.o: In function `dwc3_set_usb_core_power':
   host.c:(.text+0xf): multiple definition of `dwc3_set_usb_core_power'
   drivers/usb/dwc3/core.o:core.c:(.text+0x325): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_wakeup_capable':
   debugfs.c:(.text+0x0): multiple definition of `dwc3_simple_wakeup_capable'
   drivers/usb/dwc3/core.o:core.c:(.text+0x316): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_set_simple_data':
   debugfs.c:(.text+0x5): multiple definition of `dwc3_set_simple_data'
   drivers/usb/dwc3/core.o:core.c:(.text+0x31b): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_simple_check_quirks':
   debugfs.c:(.text+0xa): multiple definition of `dwc3_simple_check_quirks'
   drivers/usb/dwc3/core.o:core.c:(.text+0x320): first defined here
   drivers/usb/dwc3/debugfs.o: In function `dwc3_set_usb_core_power':
   debugfs.c:(.text+0xf): multiple definition of `dwc3_set_usb_core_power'
   drivers/usb/dwc3/core.o:core.c:(.text+0x325): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23158 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/ec35c60b/attachment-0001.gz>
