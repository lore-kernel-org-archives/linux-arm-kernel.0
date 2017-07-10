From: fengguang.wu@intel.com (kbuild test robot)
Date: Mon, 10 Jul 2017 14:43:34 +0800
Subject: [xlnx:master 553/744] drivers/mtd/spi-nor/spi-nor.c:2000:13: error:
 implicit declaration of function 'of_get_next_parent'
Message-ID: <201707101431.q1Xo5W0H%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Naga,

FYI, the error/warning still remains.

tree:   https://github.com/Xilinx/linux-xlnx master
head:   50dbfdba9101210db33a5a311b85a7409ab62278
commit: d80f6153e7c446e0c7dc8400b06d199c50bfd509 [553/744] mtd: spi-nor: Disable 4-Byte addressing for axi_quad_spi
config: blackfin-BF526-EZBRD_defconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d80f6153e7c446e0c7dc8400b06d199c50bfd509
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All errors (new ones prefixed by >>):

   drivers/mtd/spi-nor/spi-nor.c: In function 'spi_nor_scan':
>> drivers/mtd/spi-nor/spi-nor.c:2000:13: error: implicit declaration of function 'of_get_next_parent' [-Werror=implicit-function-declaration]
       np_spi = of_get_next_parent(np);
                ^~~~~~~~~~~~~~~~~~
   drivers/mtd/spi-nor/spi-nor.c:2000:11: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
       np_spi = of_get_next_parent(np);
              ^
   drivers/mtd/spi-nor/spi-nor.c:1728:6: warning: unused variable 'is_dual' [-Wunused-variable]
     u32 is_dual;
         ^~~~~~~
   At top level:
   drivers/mtd/spi-nor/spi-nor.c:266:12: warning: 'read_ear' defined but not used [-Wunused-function]
    static int read_ear(struct spi_nor *nor, struct flash_info *info)
               ^~~~~~~~
   cc1: some warnings being treated as errors

vim +/of_get_next_parent +2000 drivers/mtd/spi-nor/spi-nor.c

  1862	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 14537 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170710/4277abb6/attachment-0001.gz>
