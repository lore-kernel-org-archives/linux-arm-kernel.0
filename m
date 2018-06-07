From: lkp@intel.com (kbuild test robot)
Date: Thu, 7 Jun 2018 22:12:17 +0800
Subject: [xlnx:master 1122/1659] drivers/mtd/spi-nor/spi-nor.c:3334:14:
 error: implicit declaration of function 'of_get_next_parent'; did you mean
 'of_get_parent'?
Message-ID: <201806072229.2FwnE6Fj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   c2ba891326bb472da59b6a2da29aca218d337687
commit: 818f168696f561c127f161379eb5b8d1835218a2 [1122/1659] Merge tag 'v4.14' into master
config: x86_64-randconfig-i0-201822 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 818f168696f561c127f161379eb5b8d1835218a2
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/mtd/spi-nor/spi-nor.c: In function 'spi_nor_scan':
>> drivers/mtd/spi-nor/spi-nor.c:3334:14: error: implicit declaration of function 'of_get_next_parent'; did you mean 'of_get_parent'? [-Werror=implicit-function-declaration]
        np_spi = of_get_next_parent(np);
                 ^~~~~~~~~~~~~~~~~~
                 of_get_parent
   drivers/mtd/spi-nor/spi-nor.c:3334:12: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
        np_spi = of_get_next_parent(np);
               ^
   drivers/mtd/spi-nor/spi-nor.c:3080:6: warning: unused variable 'is_dual' [-Wunused-variable]
     u32 is_dual;
         ^~~~~~~
   At top level:
   drivers/mtd/spi-nor/spi-nor.c:323:12: warning: 'read_ear' defined but not used [-Wunused-function]
    static int read_ear(struct spi_nor *nor, struct flash_info *info)
               ^~~~~~~~
   Cyclomatic Complexity 1 include/linux/err.h:ERR_PTR
   Cyclomatic Complexity 1 include/linux/err.h:PTR_ERR
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:ffs
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls64
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u64
   Cyclomatic Complexity 1 include/asm-generic/getorder.h:__get_order
   Cyclomatic Complexity 1 include/linux/math64.h:div_u64_rem
   Cyclomatic Complexity 1 include/linux/kobject.h:kobject_name
   Cyclomatic Complexity 2 include/linux/device.h:dev_name
   Cyclomatic Complexity 1 include/linux/device.h:dev_of_node
   Cyclomatic Complexity 68 include/linux/slab.h:kmalloc_large
   Cyclomatic Complexity 3 include/linux/slab.h:kmalloc
   Cyclomatic Complexity 1 include/linux/of.h:of_find_property
   Cyclomatic Complexity 1 include/linux/of.h:of_property_match_string
   Cyclomatic Complexity 1 include/linux/of.h:of_property_read_bool
   Cyclomatic Complexity 1 include/linux/mtd/mtd.h:mtd_get_of_node
   Cyclomatic Complexity 1 include/linux/mtd/spi-nor.h:spi_nor_get_protocol_data_nbits
   Cyclomatic Complexity 1 include/linux/mtd/spi-nor.h:spi_nor_get_protocol_width
   Cyclomatic Complexity 1 include/linux/mtd/spi-nor.h:spi_nor_get_flash_node
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:write_sr
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:write_enable
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:write_disable
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:mtd_to_spi_nor
   Cyclomatic Complexity 3 drivers/mtd/spi-nor/spi-nor.c:spi_nor_convert_opcode
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:spi_nor_convert_3to4_read
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:spi_nor_convert_3to4_program
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:spi_nor_convert_3to4_erase
   Cyclomatic Complexity 2 drivers/mtd/spi-nor/spi-nor.c:spi_nor_set_4byte_opcodes
   Cyclomatic Complexity 6 drivers/mtd/spi-nor/spi-nor.c:set_4byte
   Cyclomatic Complexity 2 drivers/mtd/spi-nor/spi-nor.c:spi_nor_s3an_addr_convert
   Cyclomatic Complexity 4 drivers/mtd/spi-nor/spi-nor.c:spi_nor_erase_sector
   Cyclomatic Complexity 2 drivers/mtd/spi-nor/spi-nor.c:min_lockable_sectors
   Cyclomatic Complexity 3 drivers/mtd/spi-nor/spi-nor.c:get_protected_area_start
   Cyclomatic Complexity 4 drivers/mtd/spi-nor/spi-nor.c:min_protected_area_including_offset
   Cyclomatic Complexity 2 drivers/mtd/spi-nor/spi-nor.c:bp_bits_from_sr
   Cyclomatic Complexity 4 drivers/mtd/spi-nor/spi-nor.c:stm_get_locked_range
   Cyclomatic Complexity 7 drivers/mtd/spi-nor/spi-nor.c:stm_check_lock_status_sr
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:stm_is_locked_sr
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:stm_is_unlocked_sr
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:spi_nor_set_read_settings
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:spi_nor_set_pp_settings
   Cyclomatic Complexity 5 drivers/mtd/spi-nor/spi-nor.c:spi_nor_read_sfdp
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:spi_nor_set_read_settings_from_bfpt
   Cyclomatic Complexity 3 drivers/mtd/spi-nor/spi-nor.c:spi_nor_hwcaps2cmd
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:spi_nor_hwcaps_read2cmd
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:spi_nor_hwcaps_pp2cmd
   Cyclomatic Complexity 3 drivers/mtd/spi-nor/spi-nor.c:spi_nor_select_read
   Cyclomatic Complexity 3 drivers/mtd/spi-nor/spi-nor.c:spi_nor_select_pp
   Cyclomatic Complexity 2 drivers/mtd/spi-nor/spi-nor.c:spi_nor_select_erase
   Cyclomatic Complexity 2 drivers/mtd/spi-nor/spi-nor.c:read_cr
   Cyclomatic Complexity 2 drivers/mtd/spi-nor/spi-nor.c:s3an_sr_ready
   Cyclomatic Complexity 10 drivers/mtd/spi-nor/spi-nor.c:spi_nor_setup
   Cyclomatic Complexity 4 drivers/mtd/spi-nor/spi-nor.c:s3an_nor_scan
   Cyclomatic Complexity 3 drivers/mtd/spi-nor/spi-nor.c:spi_nor_lock_and_prep
   Cyclomatic Complexity 2 drivers/mtd/spi-nor/spi-nor.c:spi_nor_unlock_and_unprep
   Cyclomatic Complexity 2 drivers/mtd/spi-nor/spi-nor.c:spi_nor_is_locked
   Cyclomatic Complexity 3 include/linux/err.h:IS_ERR_OR_NULL
   Cyclomatic Complexity 1 include/linux/err.h:IS_ERR
   Cyclomatic Complexity 4 drivers/mtd/spi-nor/spi-nor.c:read_sr
   Cyclomatic Complexity 2 drivers/mtd/spi-nor/spi-nor.c:stm_is_locked
   Cyclomatic Complexity 5 drivers/mtd/spi-nor/spi-nor.c:spi_nor_sr_ready
   Cyclomatic Complexity 4 drivers/mtd/spi-nor/spi-nor.c:read_fsr
   Cyclomatic Complexity 2 drivers/mtd/spi-nor/spi-nor.c:spi_nor_fsr_ready
   Cyclomatic Complexity 5 drivers/mtd/spi-nor/spi-nor.c:spi_nor_ready
   Cyclomatic Complexity 6 drivers/mtd/spi-nor/spi-nor.c:spi_nor_check
   Cyclomatic Complexity 66 include/linux/log2.h:__order_base_2
   Cyclomatic Complexity 7 drivers/mtd/spi-nor/spi-nor.c:spi_nor_wait_till_ready_with_timeout
   Cyclomatic Complexity 1 drivers/mtd/spi-nor/spi-nor.c:spi_nor_wait_till_ready
   Cyclomatic Complexity 10 drivers/mtd/spi-nor/spi-nor.c:write_ear
   Cyclomatic Complexity 19 drivers/mtd/spi-nor/spi-nor.c:spi_nor_write
   Cyclomatic Complexity 15 drivers/mtd/spi-nor/spi-nor.c:sst_write
   Cyclomatic Complexity 3 drivers/mtd/spi-nor/spi-nor.c:write_sr_cr
   Cyclomatic Complexity 6 drivers/mtd/spi-nor/spi-nor.c:write_sr_modify_protection
   Cyclomatic Complexity 7 drivers/mtd/spi-nor/spi-nor.c:spi_nor_unlock
   Cyclomatic Complexity 4 drivers/mtd/spi-nor/spi-nor.c:spansion_quad_enable
   Cyclomatic Complexity 7 drivers/mtd/spi-nor/spi-nor.c:spansion_read_cr_quad_enable
   Cyclomatic Complexity 2 drivers/mtd/spi-nor/spi-nor.c:spansion_no_read_cr_quad_enable
   Cyclomatic Complexity 7 drivers/mtd/spi-nor/spi-nor.c:spi_nor_lock
   Cyclomatic Complexity 144 drivers/mtd/spi-nor/spi-nor.c:stm_unlock
   Cyclomatic Complexity 141 drivers/mtd/spi-nor/spi-nor.c:stm_lock
   Cyclomatic Complexity 18 drivers/mtd/spi-nor/spi-nor.c:spi_nor_read
   Cyclomatic Complexity 5 drivers/mtd/spi-nor/spi-nor.c:erase_chip
   Cyclomatic Complexity 17 drivers/mtd/spi-nor/spi-nor.c:spi_nor_erase
   Cyclomatic Complexity 6 drivers/mtd/spi-nor/spi-nor.c:macronix_quad_enable
   Cyclomatic Complexity 7 drivers/mtd/spi-nor/spi-nor.c:sr2_bit7_quad_enable
   Cyclomatic Complexity 3 drivers/mtd/spi-nor/spi-nor.c:spi_nor_match_id

vim +3334 drivers/mtd/spi-nor/spi-nor.c

b199489d3 Huang Shijie            2014-02-24  3270  
b199489d3 Huang Shijie            2014-02-24  3271  	if (info->flags & SPI_NOR_NO_ERASE)
b199489d3 Huang Shijie            2014-02-24  3272  		mtd->flags |= MTD_NO_ERASE;
b199489d3 Huang Shijie            2014-02-24  3273  
29e641775 Naga Sureshkumar Relli  2017-03-06  3274  	nor->jedec_id = info->id[0];
b199489d3 Huang Shijie            2014-02-24  3275  	mtd->dev.parent = dev;
cfc5604c4 Cyrille Pitchen         2017-04-25  3276  	nor->page_size = params.page_size;
b199489d3 Huang Shijie            2014-02-24  3277  	mtd->writebufsize = nor->page_size;
b199489d3 Huang Shijie            2014-02-24  3278  
b199489d3 Huang Shijie            2014-02-24  3279  	if (np) {
b199489d3 Huang Shijie            2014-02-24  3280  		/* If we were instantiated by DT, use it */
b199489d3 Huang Shijie            2014-02-24  3281  		if (of_property_read_bool(np, "m25p,fast-read"))
cfc5604c4 Cyrille Pitchen         2017-04-25  3282  			params.hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
b199489d3 Huang Shijie            2014-02-24  3283  		else
cfc5604c4 Cyrille Pitchen         2017-04-25  3284  			params.hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
b199489d3 Huang Shijie            2014-02-24  3285  	} else {
b199489d3 Huang Shijie            2014-02-24  3286  		/* If we weren't instantiated by DT, default to fast-read */
cfc5604c4 Cyrille Pitchen         2017-04-25  3287  		params.hwcaps.mask |= SNOR_HWCAPS_READ_FAST;
b199489d3 Huang Shijie            2014-02-24  3288  	}
b199489d3 Huang Shijie            2014-02-24  3289  
b199489d3 Huang Shijie            2014-02-24  3290  	/* Some devices cannot do fast-read, no matter what DT tells us */
b199489d3 Huang Shijie            2014-02-24  3291  	if (info->flags & SPI_NOR_NO_FR)
cfc5604c4 Cyrille Pitchen         2017-04-25  3292  		params.hwcaps.mask &= ~SNOR_HWCAPS_READ_FAST;
b199489d3 Huang Shijie            2014-02-24  3293  
cfc5604c4 Cyrille Pitchen         2017-04-25  3294  	/*
cfc5604c4 Cyrille Pitchen         2017-04-25  3295  	 * Configure the SPI memory:
cfc5604c4 Cyrille Pitchen         2017-04-25  3296  	 * - select op codes for (Fast) Read, Page Program and Sector Erase.
cfc5604c4 Cyrille Pitchen         2017-04-25  3297  	 * - set the number of dummy cycles (mode cycles + wait states).
cfc5604c4 Cyrille Pitchen         2017-04-25  3298  	 * - set the SPI protocols for register and memory accesses.
cfc5604c4 Cyrille Pitchen         2017-04-25  3299  	 * - set the Quad Enable bit if needed (required by SPI x-y-4 protos).
cfc5604c4 Cyrille Pitchen         2017-04-25  3300  	 */
cfc5604c4 Cyrille Pitchen         2017-04-25  3301  	ret = spi_nor_setup(nor, info, &params, hwcaps);
cfc5604c4 Cyrille Pitchen         2017-04-25  3302  	if (ret)
b199489d3 Huang Shijie            2014-02-24  3303  		return ret;
b199489d3 Huang Shijie            2014-02-24  3304  
f384b352c Cyrille Pitchen         2017-06-26  3305  	if (nor->addr_width) {
f384b352c Cyrille Pitchen         2017-06-26  3306  		/* already configured from SFDP */
f384b352c Cyrille Pitchen         2017-06-26  3307  	} else if (info->addr_width) {
b199489d3 Huang Shijie            2014-02-24  3308  		nor->addr_width = info->addr_width;
f384b352c Cyrille Pitchen         2017-06-26  3309  	} else if (mtd->size > 0x1000000) {
1e7078305 Michal Simek            2017-01-24  3310  #ifdef CONFIG_OF
1e7078305 Michal Simek            2017-01-24  3311  		np_spi = of_get_next_parent(np);
1e7078305 Michal Simek            2017-01-24  3312  		if (of_property_match_string(np_spi, "compatible",
1e7078305 Michal Simek            2017-01-24  3313  					     "xlnx,zynq-qspi-1.0") >= 0) {
1e7078305 Michal Simek            2017-01-24  3314  			int status;
1e7078305 Michal Simek            2017-01-24  3315  
1e7078305 Michal Simek            2017-01-24  3316  			nor->addr_width = 3;
1e7078305 Michal Simek            2017-01-24  3317  			set_4byte(nor, info, 0);
1e7078305 Michal Simek            2017-01-24  3318  			status = read_ear(nor, info);
1e7078305 Michal Simek            2017-01-24  3319  			if (status < 0)
1e7078305 Michal Simek            2017-01-24  3320  				dev_warn(dev, "failed to read ear reg\n");
1e7078305 Michal Simek            2017-01-24  3321  			else
1e7078305 Michal Simek            2017-01-24  3322  				nor->curbank = status & EAR_SEGMENT_MASK;
1e7078305 Michal Simek            2017-01-24  3323  		} else {
1e7078305 Michal Simek            2017-01-24  3324  #endif
818f16869 Michal Simek            2018-01-11  3325  			/*
818f16869 Michal Simek            2018-01-11  3326  			 * enable 4-byte addressing
818f16869 Michal Simek            2018-01-11  3327  			 * if the device exceeds 16MiB
818f16869 Michal Simek            2018-01-11  3328  			 */
b199489d3 Huang Shijie            2014-02-24  3329  			nor->addr_width = 4;
ba3ae6a1d Cyrille Pitchen         2016-10-27  3330  			if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
ba3ae6a1d Cyrille Pitchen         2016-10-27  3331  			    info->flags & SPI_NOR_4B_OPCODES)
ba3ae6a1d Cyrille Pitchen         2016-10-27  3332  				spi_nor_set_4byte_opcodes(nor, info);
818f16869 Michal Simek            2018-01-11  3333  			else {
d80f6153e Naga Sureshkumar Relli  2017-04-18 @3334  				np_spi = of_get_next_parent(np);
818f16869 Michal Simek            2018-01-11  3335  				if (of_property_match_string(np_spi,
818f16869 Michal Simek            2018-01-11  3336  						"compatible",
d80f6153e Naga Sureshkumar Relli  2017-04-18  3337  						"xlnx,xps-spi-2.00.a") >= 0) {
d80f6153e Naga Sureshkumar Relli  2017-04-18  3338  					nor->addr_width = 3;
d80f6153e Naga Sureshkumar Relli  2017-04-18  3339  					set_4byte(nor, info, 0);
d80f6153e Naga Sureshkumar Relli  2017-04-18  3340  				} else {
d928a2593 Huang Shijie            2014-11-06  3341  					set_4byte(nor, info, 1);
d859d3457 Anurag Kumar Vulisha    2015-05-13  3342  					if (nor->isstacked) {
d80f6153e Naga Sureshkumar Relli  2017-04-18  3343  						nor->spi->master->flags |=
d80f6153e Naga Sureshkumar Relli  2017-04-18  3344  							SPI_MASTER_U_PAGE;
d859d3457 Anurag Kumar Vulisha    2015-05-13  3345  						set_4byte(nor, info, 1);
d80f6153e Naga Sureshkumar Relli  2017-04-18  3346  						nor->spi->master->flags &=
d80f6153e Naga Sureshkumar Relli  2017-04-18  3347  							~SPI_MASTER_U_PAGE;
d80f6153e Naga Sureshkumar Relli  2017-04-18  3348  					}
d80f6153e Naga Sureshkumar Relli  2017-04-18  3349  				}
d859d3457 Anurag Kumar Vulisha    2015-05-13  3350  			}
1e7078305 Michal Simek            2017-01-24  3351  #ifdef CONFIG_OF
1e7078305 Michal Simek            2017-01-24  3352  		}
1e7078305 Michal Simek            2017-01-24  3353  #endif
b199489d3 Huang Shijie            2014-02-24  3354  	} else {
b199489d3 Huang Shijie            2014-02-24  3355  		nor->addr_width = 3;
b199489d3 Huang Shijie            2014-02-24  3356  	}
b199489d3 Huang Shijie            2014-02-24  3357  
c67cbb839 Brian Norris            2015-11-10  3358  	if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
c67cbb839 Brian Norris            2015-11-10  3359  		dev_err(dev, "address width is too large: %u\n",
c67cbb839 Brian Norris            2015-11-10  3360  			nor->addr_width);
c67cbb839 Brian Norris            2015-11-10  3361  		return -EINVAL;
c67cbb839 Brian Norris            2015-11-10  3362  	}
c67cbb839 Brian Norris            2015-11-10  3363  
e99ca98f1 Ricardo Ribalda Delgado 2016-12-02  3364  	if (info->flags & SPI_S3AN) {
e99ca98f1 Ricardo Ribalda Delgado 2016-12-02  3365  		ret = s3an_nor_scan(info, nor);
e99ca98f1 Ricardo Ribalda Delgado 2016-12-02  3366  		if (ret)
e99ca98f1 Ricardo Ribalda Delgado 2016-12-02  3367  			return ret;
e99ca98f1 Ricardo Ribalda Delgado 2016-12-02  3368  	}
b199489d3 Huang Shijie            2014-02-24  3369  
7ae20097f Naga Sureshkumar Relli  2017-01-30  3370  	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
b199489d3 Huang Shijie            2014-02-24  3371  			(long long)mtd->size >> 10);
b199489d3 Huang Shijie            2014-02-24  3372  
7ae20097f Naga Sureshkumar Relli  2017-01-30  3373  	dev_dbg(dev,
7ae20097f Naga Sureshkumar Relli  2017-01-30  3374  		"mtd .name = %s, .size = 0x%llx (%lldMiB), "
b199489d3 Huang Shijie            2014-02-24  3375  		".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
b199489d3 Huang Shijie            2014-02-24  3376  		mtd->name, (long long)mtd->size, (long long)(mtd->size >> 20),
b199489d3 Huang Shijie            2014-02-24  3377  		mtd->erasesize, mtd->erasesize / 1024, mtd->numeraseregions);
b199489d3 Huang Shijie            2014-02-24  3378  
b199489d3 Huang Shijie            2014-02-24  3379  	if (mtd->numeraseregions)
b199489d3 Huang Shijie            2014-02-24  3380  		for (i = 0; i < mtd->numeraseregions; i++)
7ae20097f Naga Sureshkumar Relli  2017-01-30  3381  			dev_dbg(dev,
7ae20097f Naga Sureshkumar Relli  2017-01-30  3382  				"mtd.eraseregions[%d] = { .offset = 0x%llx, "
b199489d3 Huang Shijie            2014-02-24  3383  				".erasesize = 0x%.8x (%uKiB), "
b199489d3 Huang Shijie            2014-02-24  3384  				".numblocks = %d }\n",
b199489d3 Huang Shijie            2014-02-24  3385  				i, (long long)mtd->eraseregions[i].offset,
b199489d3 Huang Shijie            2014-02-24  3386  				mtd->eraseregions[i].erasesize,
b199489d3 Huang Shijie            2014-02-24  3387  				mtd->eraseregions[i].erasesize / 1024,
b199489d3 Huang Shijie            2014-02-24  3388  				mtd->eraseregions[i].numblocks);
b199489d3 Huang Shijie            2014-02-24  3389  	return 0;
b199489d3 Huang Shijie            2014-02-24  3390  }
b61834b0d Brian Norris            2014-04-08  3391  EXPORT_SYMBOL_GPL(spi_nor_scan);
b199489d3 Huang Shijie            2014-02-24  3392  

:::::: The code at line 3334 was first introduced by commit
:::::: d80f6153e7c446e0c7dc8400b06d199c50bfd509 mtd: spi-nor: Disable 4-Byte addressing for axi_quad_spi

:::::: TO: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26841 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180607/6ee1dd7c/attachment-0001.gz>
