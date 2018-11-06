From: lkp@intel.com (kbuild test robot)
Date: Tue, 6 Nov 2018 13:25:11 +0800
Subject: [nomadik:openwrt-v4.19 11/14] drivers/mtd//parsers/redboot.c:322:25:
 error: 'mtd_parser_trx_of_match_table' undeclared here (not in a
 function)
Message-ID: <201811061306.tbOqD7rk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git openwrt-v4.19
head:   185419968f1800b634d5a4a447f71f12be7db563
commit: 4acc920d4e10237cc0a8dc36feed4607fb52869b [11/14] mtd: partitions: Add OF support to RedBoot partitions
config: i386-randconfig-s0-201844 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout 4acc920d4e10237cc0a8dc36feed4607fb52869b
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from drivers/mtd//parsers/redboot.c:31:0:
>> drivers/mtd//parsers/redboot.c:322:25: error: 'mtd_parser_trx_of_match_table' undeclared here (not in a function)
    MODULE_DEVICE_TABLE(of, mtd_parser_trx_of_match_table);
                            ^
   include/linux/module.h:214:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
    extern typeof(name) __mod_##type##__##name##_device_table  \
                  ^~~~
   include/linux/module.h:214:21: error: '__mod_of__mtd_parser_trx_of_match_table_device_table' aliased to undefined symbol 'mtd_parser_trx_of_match_table'
    extern typeof(name) __mod_##type##__##name##_device_table  \
                        ^
   drivers/mtd//parsers/redboot.c:322:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
    MODULE_DEVICE_TABLE(of, mtd_parser_trx_of_match_table);
    ^~~~~~~~~~~~~~~~~~~

vim +/mtd_parser_trx_of_match_table +322 drivers/mtd//parsers/redboot.c

   317	
   318	static const struct of_device_id mtd_parser_redboot_of_match_table[] = {
   319		{ .compatible = "redboot-fis" },
   320		{},
   321	};
 > 322	MODULE_DEVICE_TABLE(of, mtd_parser_trx_of_match_table);
   323	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35523 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181106/b42c099b/attachment-0001.gz>
