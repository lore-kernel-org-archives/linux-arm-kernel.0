From: lkp@intel.com (kbuild test robot)
Date: Fri, 1 Apr 2016 22:13:43 +0800
Subject: [PATCH 12/12] mtd: nand: move of_get_nand_xxx() helpers into
 nand_base.c
In-Reply-To: <1459515272-31011-13-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <201604012200.EksFk1z5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

[auto build test WARNING on next-20160401]
[cannot apply to v4.6-rc1 v4.5-rc7 v4.5-rc6 v4.6-rc1]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Boris-Brezillon/mtd-get-rid-of-of_mtd-c-h-and-of_get_nand_xx/20160401-210220
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/nand_base.c:3972: warning: cannot understand function prototype: 'const char * const nand_ecc_modes[] = '
   drivers/mtd/nand/nand_bbt.c:1: warning: no structured comments found
>> drivers/mtd/nand/nand_base.c:3972: warning: cannot understand function prototype: 'const char * const nand_ecc_modes[] = '

vim +3972 drivers/mtd/nand/nand_base.c

  3956					chip->jedec_params.model);
  3957		else
  3958			pr_info("%s %s\n", nand_manuf_ids[maf_idx].name,
  3959					type->name);
  3960	
  3961		pr_info("%d MiB, %s, erase size: %d KiB, page size: %d, OOB size: %d\n",
  3962			(int)(chip->chipsize >> 20), nand_is_slc(chip) ? "SLC" : "MLC",
  3963			mtd->erasesize >> 10, mtd->writesize, mtd->oobsize);
  3964		return type;
  3965	}
  3966	
  3967	/**
  3968	 * It maps 'enum nand_ecc_modes_t' found in include/linux/mtd/nand.h
  3969	 * into the device tree binding of 'nand-ecc', so that MTD
  3970	 * device driver can get nand ecc from device tree.
  3971	 */
> 3972	static const char * const nand_ecc_modes[] = {
  3973		[NAND_ECC_NONE]		= "none",
  3974		[NAND_ECC_SOFT]		= "soft",
  3975		[NAND_ECC_HW]		= "hw",
  3976		[NAND_ECC_HW_SYNDROME]	= "hw_syndrome",
  3977		[NAND_ECC_HW_OOB_FIRST]	= "hw_oob_first",
  3978		[NAND_ECC_SOFT_BCH]	= "soft_bch",
  3979	};
  3980	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 6305 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160401/75ff6d71/attachment.obj>
