From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 14 Jan 2018 17:09:56 +0800
Subject: [arm-soc:xlnx/soc 3/3] collect2: error: ld returned 1 exit status
Message-ID: <201801141754.lROQHRMR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git xlnx/soc
head:   cee8113a295acfc4cd25728d7c3d44e6bc3bbff9
commit: cee8113a295acfc4cd25728d7c3d44e6bc3bbff9 [3/3] soc: xilinx: xlnx_vcu: Add Xilinx ZYNQMP VCU logicoreIP init driver
config: um-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout cee8113a295acfc4cd25728d7c3d44e6bc3bbff9
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by >>):

   arch/um/drivers/vde.o: In function `vde_open_real':
   (.text+0x951): warning: Using 'getgrnam' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   (.text+0x79c): warning: Using 'getpwuid' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   (.text+0xab5): warning: Using 'getaddrinfo' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/pcap.o: In function `pcap_nametoaddr':
   (.text+0xdee5): warning: Using 'gethostbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/pcap.o: In function `pcap_nametonetaddr':
   (.text+0xdf85): warning: Using 'getnetbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/pcap.o: In function `pcap_nametoproto':
   (.text+0xe1a5): warning: Using 'getprotobyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   arch/um/drivers/pcap.o: In function `pcap_nametoport':
   (.text+0xdfd7): warning: Using 'getservbyname' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
   drivers/soc/xilinx/xlnx_vcu.o: In function `xvcu_probe':
   xlnx_vcu.c:(.text+0x116): undefined reference to `devm_ioremap_nocache'
   xlnx_vcu.c:(.text+0x1ae): undefined reference to `devm_ioremap_nocache'
>> collect2: error: ld returned 1 exit status

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19866 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180114/7a8275cf/attachment-0001.gz>
