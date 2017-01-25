From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 25 Jan 2017 11:26:39 +0800
Subject: [xlnx:master 110/163] drivers/mtd/nand/arasan_nand.c:99:0: warning:
 "ONFI_DATA_INTERFACE_NVDDR" redefined
Message-ID: <201701251131.8nRnCPhm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   a96b8d2e1c9b37de51590b63bcce63a4036e760a
commit: 6c59929c53d7b0c45e575999714c717ae30909b1 [110/163] mtd: nand: Update Arasan Nand flash controller
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 6c59929c53d7b0c45e575999714c717ae30909b1
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/arasan_nand.c:99:0: warning: "ONFI_DATA_INTERFACE_NVDDR" redefined
    #define ONFI_DATA_INTERFACE_NVDDR      BIT(4)
    
   In file included from drivers/mtd/nand/arasan_nand.c:18:0:
   include/linux/mtd/nand.h:238:0: note: this is the location of the previous definition
    #define ONFI_DATA_INTERFACE_NVDDR (1 << 4)
    
   drivers/mtd/nand/arasan_nand.c: In function 'anfc_cmd_function':
   drivers/mtd/nand/arasan_nand.c:568:7: warning: unused variable 'bufptr' [-Wunused-variable]
     u32 *bufptr = (u32 *)nfc->buf;
          ^~~~~~

vim +/ONFI_DATA_INTERFACE_NVDDR +99 drivers/mtd/nand/arasan_nand.c

    83	#define BCH_MODE_MASK			GENMASK(27, 25)
    84	
    85	#define CS_MASK				GENMASK(31, 30)
    86	#define CS_SHIFT			30
    87	
    88	#define PAGE_ERR_CNT_MASK		GENMASK(16, 8)
    89	#define PKT_ERR_CNT_MASK		GENMASK(7, 0)
    90	
    91	#define NVDDR_MODE			BIT(9)
    92	#define NVDDR_TIMING_MODE_SHIFT		3
    93	
    94	#define ONFI_ID_LEN			8
    95	#define TEMP_BUF_SIZE			1024
    96	#define NVDDR_MODE_PACKET_SIZE		8
    97	#define SDR_MODE_PACKET_SIZE		4
    98	
  > 99	#define ONFI_DATA_INTERFACE_NVDDR      BIT(4)
   100	#define EVENT_MASK	(XFER_COMPLETE | READ_READY | WRITE_READY | MBIT_ERROR)
   101	
   102	/**
   103	 * struct anfc_nand_chip - Defines the nand chip related information
   104	 * @node:		used to store NAND chips into a list.
   105	 * @chip:		NAND chip information structure.
   106	 * @bch:		Bch / Hamming mode enable/disable.
   107	 * @bchmode:		Bch mode.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55406 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/f6adfed9/attachment-0001.gz>
