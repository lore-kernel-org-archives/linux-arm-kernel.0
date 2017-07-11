From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 12 Jul 2017 02:35:48 +0800
Subject: [nomadik:gemini-dir-685-tve200 21/21]
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c:243:2: note: in expansion of
 macro 'dev_dbg'
Message-ID: <201707120246.9gROBL7q%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-dir-685-tve200
head:   eb3f2b9691343dbf5ea9202b01e71a01480a2df2
commit: eb3f2b9691343dbf5ea9202b01e71a01480a2df2 [21/21] stab
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout eb3f2b9691343dbf5ea9202b01e71a01480a2df2
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   include/linux/compiler.h:260:8: sparse: attribute 'no_sanitize_address': unknown attribute
   In file included from include/linux/printk.h:329:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/agp_backend.h:33,
                    from include/drm/drmP.h:35,
                    from drivers/gpu/drm/panel/panel-ilitek-ili9322.c:25:
   drivers/gpu/drm/panel/panel-ilitek-ili9322.c: In function 'ili9322_regmap_spi_read':
   drivers/gpu/drm/panel/panel-ilitek-ili9322.c:243:15: warning: format '%d' expects argument of type 'int', but argument 5 has type 'size_t {aka long unsigned int}' [-Wformat=]
     dev_dbg(dev, "READ: %02x reg size = %d, val size = %d\n",
                  ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/gpu/drm/panel/panel-ilitek-ili9322.c:243:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dev, "READ: %02x reg size = %d, val size = %d\n",
     ^~~~~~~
   drivers/gpu/drm/panel/panel-ilitek-ili9322.c:243:15: warning: format '%d' expects argument of type 'int', but argument 6 has type 'size_t {aka long unsigned int}' [-Wformat=]
     dev_dbg(dev, "READ: %02x reg size = %d, val size = %d\n",
                  ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/gpu/drm/panel/panel-ilitek-ili9322.c:243:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dev, "READ: %02x reg size = %d, val size = %d\n",
     ^~~~~~~

vim +/dev_dbg +243 drivers/gpu/drm/panel/panel-ilitek-ili9322.c

   233	
   234	static int ili9322_regmap_spi_read(void *context, const void *reg,
   235					   size_t reg_size, void *val, size_t val_size)
   236	{
   237		struct device *dev = context;
   238		struct spi_device *spi = to_spi_device(dev);
   239		u8 buf[1];
   240	
   241		/* Set bit 7 to 1 to read */
   242		memcpy(buf, reg, 1);
 > 243		dev_dbg(dev, "READ: %02x reg size = %d, val size = %d\n",
   244			buf[0], reg_size, val_size);
   245		buf[0] |= 0x80;
   246	
   247		return spi_write_then_read(spi, buf, 1, val, 1);
   248	}
   249	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60798 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170712/fd2d86e2/attachment-0001.gz>
