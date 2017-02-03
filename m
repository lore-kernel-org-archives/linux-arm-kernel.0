From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 3 Feb 2017 21:39:33 +0800
Subject: [xlnx:master 117/172] drivers/mtd/spi-nor/spi-nor.c:1423: warning:
 unused variable 'is_dual'
Message-ID: <201702032124.qdhYYrJJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   b11f1d3fcb6195933acc39b8d26891847a5ea24d
commit: 15add85f47f37fde03343fb06bb7240dc61155e6 [117/172] Merge tag 'v4.8' into master
config: x86_64-randconfig-s0-02031930 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        git checkout 15add85f47f37fde03343fb06bb7240dc61155e6
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/mtd/spi-nor/spi-nor.c: In function 'spi_nor_scan':
>> drivers/mtd/spi-nor/spi-nor.c:1423: warning: unused variable 'is_dual'
   drivers/mtd/spi-nor/spi-nor.c:1420: warning: unused variable 'np_spi'

vim +/is_dual +1423 drivers/mtd/spi-nor/spi-nor.c

  1407			pr_err("spi-nor: please fill all the necessary fields!\n");
  1408			return -EINVAL;
  1409		}
  1410	
  1411		return 0;
  1412	}
  1413	
  1414	int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
  1415	{
  1416		struct flash_info *info = NULL;
  1417		struct device *dev = nor->dev;
  1418		struct mtd_info *mtd = &nor->mtd;
  1419		struct device_node *np = spi_nor_get_flash_node(nor);
  1420		struct device_node *np_spi ;
  1421		int ret;
  1422		int i;
> 1423		u32 is_dual;
  1424	
  1425		ret = spi_nor_check(nor);
  1426		if (ret)
  1427			return ret;
  1428	
  1429		if (name)
  1430			info = (struct flash_info *)spi_nor_match_id(name);
  1431		/* Try to auto-detect if chip name wasn't specified or not found */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23881 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170203/a737931b/attachment-0001.gz>
