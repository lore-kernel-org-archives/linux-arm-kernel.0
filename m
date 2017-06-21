From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 21 Jun 2017 16:42:30 +0800
Subject: [xlnx:master 688/710] drivers/gpu//drm/xylon/xylon_drv.c:247:19:
 error: initialization from incompatible pointer type
Message-ID: <201706211628.BwfSNSbq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   ae4bbf82f4b9fdfc85b3fd112696e8bbefff07f2
commit: 472236088ad190937efa1be2d96965f9bb7c9bcb [688/710] kbuild: Add option to turn incompatible pointer check into error
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 472236088ad190937efa1be2d96965f9bb7c9bcb
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

>> drivers/gpu//drm/xylon/xylon_drv.c:247:19: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .enable_vblank = xylon_drm_vblank_enable,
                      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu//drm/xylon/xylon_drv.c:247:19: note: (near initialization for 'xylon_drm_driver.enable_vblank')
   drivers/gpu//drm/xylon/xylon_drv.c:248:20: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .disable_vblank = xylon_drm_vblank_disable,
                       ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu//drm/xylon/xylon_drv.c:248:20: note: (near initialization for 'xylon_drm_driver.disable_vblank')
   cc1: some warnings being treated as errors
--
>> drivers/gpu//drm/xylon/xylon_fb.c:132:15: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .fb_create = xylon_drm_fb_create,
                  ^~~~~~~~~~~~~~~~~~~
   drivers/gpu//drm/xylon/xylon_fb.c:132:15: note: (near initialization for 'xylon_drm_mode_config_funcs.fb_create')
   cc1: some warnings being treated as errors

vim +247 drivers/gpu//drm/xylon/xylon_drv.c

7100d698 Davor Joja 2014-03-24  231  #ifdef CONFIG_COMPAT
7100d698 Davor Joja 2014-03-24  232  	.compat_ioctl = drm_compat_ioctl,
7100d698 Davor Joja 2014-03-24  233  #endif
7100d698 Davor Joja 2014-03-24  234  	.llseek = noop_llseek,
7100d698 Davor Joja 2014-03-24  235  };
7100d698 Davor Joja 2014-03-24  236  
7100d698 Davor Joja 2014-03-24  237  static struct drm_driver xylon_drm_driver = {
7100d698 Davor Joja 2014-03-24  238  	.driver_features = DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED |
7100d698 Davor Joja 2014-03-24  239  			   DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME,
7100d698 Davor Joja 2014-03-24  240  	.load = xylon_drm_load,
7100d698 Davor Joja 2014-03-24  241  	.unload = xylon_drm_unload,
7100d698 Davor Joja 2014-03-24  242  	.preclose = xylon_drm_preclose,
7100d698 Davor Joja 2014-03-24  243  	.postclose = xylon_drm_postclose,
7100d698 Davor Joja 2014-03-24  244  	.lastclose = xylon_drm_lastclose,
7100d698 Davor Joja 2014-03-24  245  
7100d698 Davor Joja 2014-03-24  246  	.get_vblank_counter = drm_vblank_count,
7100d698 Davor Joja 2014-03-24 @247  	.enable_vblank = xylon_drm_vblank_enable,
7100d698 Davor Joja 2014-03-24  248  	.disable_vblank = xylon_drm_vblank_disable,
7100d698 Davor Joja 2014-03-24  249  
7100d698 Davor Joja 2014-03-24  250  	.irq_preinstall = xylon_drm_irq_preinst,
7100d698 Davor Joja 2014-03-24  251  	.irq_postinstall = xylon_drm_irq_postinst,
7100d698 Davor Joja 2014-03-24  252  	.irq_uninstall = xylon_drm_irq_uninst,
7100d698 Davor Joja 2014-03-24  253  	.irq_handler = xylon_drm_irq_handler,
7100d698 Davor Joja 2014-03-24  254  
7100d698 Davor Joja 2014-03-24  255  	.gem_free_object = drm_gem_cma_free_object,

:::::: The code at line 247 was first introduced by commit
:::::: 7100d6985a5c7e1c2758ddab9bebd972823ed85c gpu: drm: xylon: Add a Xylon DRM driver

:::::: TO: Davor Joja <davorjoja@logicbricks.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45269 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170621/844433a1/attachment-0001.gz>
