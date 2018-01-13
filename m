From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 13 Jan 2018 10:53:47 +0800
Subject: [nomadik:gemini-ethernet 9/9] gemini.c:undefined reference to
 `devm_ioremap_resource'
Message-ID: <201801131044.SMHrEI4e%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-ethernet
head:   c5fab9815a7a1857155a7911fbce85d1af11ab8f
commit: c5fab9815a7a1857155a7911fbce85d1af11ab8f [9/9] net: ethernet: Add a driver for Gemini gigabit ethernet
config: um-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout c5fab9815a7a1857155a7911fbce85d1af11ab8f
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
   drivers/net/ethernet/cortina/gemini.o: In function `geth_cleanup_freeq':
>> gemini.c:(.text+0x97d): undefined reference to `bad_dma_ops'
   gemini.c:(.text+0xad5): undefined reference to `bad_dma_ops'
   gemini.c:(.text+0xb85): undefined reference to `bad_dma_ops'
   drivers/net/ethernet/cortina/gemini.o: In function `gemini_ethernet_probe':
>> gemini.c:(.text+0xd2b): undefined reference to `devm_ioremap_resource'
   drivers/net/ethernet/cortina/gemini.o: In function `geth_freeq_alloc_map_page':
   gemini.c:(.text+0x11c4): undefined reference to `bad_dma_ops'
   gemini.c:(.text+0x11d0): undefined reference to `bad_dma_ops'
   gemini.c:(.text+0x13dc): undefined reference to `bad_dma_ops'
   drivers/net/ethernet/cortina/gemini.o: In function `geth_resize_freeq':
   gemini.c:(.text+0x1ead): undefined reference to `bad_dma_ops'
   gemini.c:(.text+0x20a4): undefined reference to `bad_dma_ops'
   drivers/net/ethernet/cortina/gemini.o:gemini.c:(.text+0x2247): more undefined references to `bad_dma_ops' follow
   drivers/net/ethernet/cortina/gemini.o: In function `gemini_ethernet_port_probe':
   gemini.c:(.text+0x2dec): undefined reference to `devm_ioremap_resource'
   gemini.c:(.text+0x2e4c): undefined reference to `devm_ioremap_resource'
   drivers/net/ethernet/cortina/gemini.o: In function `gmac_map_tx_bufs.isra.0':
   gemini.c:(.text+0x37fb): undefined reference to `bad_dma_ops'
   gemini.c:(.text+0x3813): undefined reference to `bad_dma_ops'
   gemini.c:(.text+0x393a): undefined reference to `bad_dma_ops'
   drivers/net/ethernet/cortina/gemini.o: In function `gmac_cleanup_rxq':
   gemini.c:(.text+0x3ffa): undefined reference to `bad_dma_ops'
   gemini.c:(.text+0x409d): undefined reference to `bad_dma_ops'
   drivers/net/ethernet/cortina/gemini.o:gemini.c:(.text+0x4245): more undefined references to `bad_dma_ops' follow
   collect2: error: ld returned 1 exit status

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 19820 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180113/798eda0e/attachment-0001.gz>
