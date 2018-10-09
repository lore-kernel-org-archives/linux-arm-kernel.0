From: lkp@intel.com (kbuild test robot)
Date: Wed, 10 Oct 2018 00:56:25 +0800
Subject: [stericsson:ux500-mcde 9/9] mcde_dsi.c:(.init.text+0x0): multiple
 definition of `init_module'
Message-ID: <201810100018.ozbwAlaQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-mcde
head:   d74bab74ec7c93c05538d1d600dba240e00798e2
commit: d74bab74ec7c93c05538d1d600dba240e00798e2 [9/9] drm/mcde: Add new driver for ST-Ericsson MCDE
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d74bab74ec7c93c05538d1d600dba240e00798e2
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/mcde/mcde_dsi.o: In function `mcde_dsi_driver_init':
>> mcde_dsi.c:(.init.text+0x0): multiple definition of `init_module'
   drivers/gpu/drm/mcde/mcde_drv.o:mcde_drv.c:(.init.text+0x0): first defined here
   drivers/gpu/drm/mcde/mcde_dsi.o: In function `mcde_dsi_driver_exit':
>> mcde_dsi.c:(.exit.text+0x0): multiple definition of `cleanup_module'
   drivers/gpu/drm/mcde/mcde_drv.o:mcde_drv.c:(.exit.text+0x0): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55262 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181010/ba6c73e7/attachment-0001.gz>
