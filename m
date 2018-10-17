From: lkp@intel.com (kbuild test robot)
Date: Wed, 17 Oct 2018 19:27:27 +0800
Subject: [xlnx:master 2087/2087] drivers/md/linear.c:68:16: error:
 incompatible types in comparison expression (different address spaces)
Message-ID: <201810171921.PyyvAsLR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   4d97746570a6e51f834bbf2758a4b4c33308428d
commit: 4d97746570a6e51f834bbf2758a4b4c33308428d [2087/2087] xilinx: v4l: vipp: Avoid decrementing refcount of a node twice
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 4d97746570a6e51f834bbf2758a4b4c33308428d
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

>> drivers/md/linear.c:68:16: error: incompatible types in comparison expression (different address spaces)
   drivers/md/linear.c:227:19: error: incompatible types in comparison expression (different address spaces)
--
   include/drm/drm_syncobj.h:120:41: warning: incorrect type in argument 1 (different address spaces)
   include/drm/drm_syncobj.h:120:41:    expected struct dma_fence *[noderef] <asn:4>*fencep
   include/drm/drm_syncobj.h:120:41:    got struct dma_fence **<noident>
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
>> include/linux/dma-fence.h:250:25: error: incompatible types in comparison expression (different address spaces)
   include/linux/dma-fence.h:268:30: error: incompatible types in comparison expression (different address spaces)
   include/drm/drm_syncobj.h:120:41: warning: incorrect type in argument 1 (different address spaces)
   include/drm/drm_syncobj.h:120:41:    expected struct dma_fence *[noderef] <asn:4>*fencep
   include/drm/drm_syncobj.h:120:41:    got struct dma_fence **<noident>
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
>> include/linux/dma-fence.h:250:25: error: incompatible types in comparison expression (different address spaces)
   include/linux/dma-fence.h:268:30: error: incompatible types in comparison expression (different address spaces)
   drivers/gpu/drm/drm_syncobj.c:420:5: warning: symbol 'drm_syncobj_import_sync_file_fence' was not declared. Should it be static?
   drivers/gpu/drm/drm_syncobj.c:441:5: warning: symbol 'drm_syncobj_export_sync_file' was not declared. Should it be static?
   include/drm/drm_syncobj.h:120:41: warning: incorrect type in argument 1 (different address spaces)
   include/drm/drm_syncobj.h:120:41:    expected struct dma_fence *[noderef] <asn:4>*fencep
   include/drm/drm_syncobj.h:120:41:    got struct dma_fence **<noident>
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
>> include/linux/dma-fence.h:250:25: error: incompatible types in comparison expression (different address spaces)
   include/linux/dma-fence.h:268:30: error: incompatible types in comparison expression (different address spaces)
   drivers/gpu/drm/drm_syncobj.c:813:37: warning: incorrect type in argument 2 (different address spaces)
   drivers/gpu/drm/drm_syncobj.c:813:37:    expected void const [noderef] <asn:1>*from
   drivers/gpu/drm/drm_syncobj.c:813:37:    got void *user_handles
   drivers/gpu/drm/drm_syncobj.c:875:38: warning: incorrect type in argument 2 (different address spaces)
   drivers/gpu/drm/drm_syncobj.c:875:38:    expected void *user_handles
   drivers/gpu/drm/drm_syncobj.c:875:38:    got void [noderef] <asn:1>*<noident>
   drivers/gpu/drm/drm_syncobj.c:908:38: warning: incorrect type in argument 2 (different address spaces)
   drivers/gpu/drm/drm_syncobj.c:908:38:    expected void *user_handles
   drivers/gpu/drm/drm_syncobj.c:908:38:    got void [noderef] <asn:1>*<noident>
   drivers/gpu/drm/drm_syncobj.c:941:38: warning: incorrect type in argument 2 (different address spaces)
   drivers/gpu/drm/drm_syncobj.c:941:38:    expected void *user_handles
   drivers/gpu/drm/drm_syncobj.c:941:38:    got void [noderef] <asn:1>*<noident>
--
   include/linux/reservation.h:239:41: warning: incorrect type in argument 1 (different address spaces)
   include/linux/reservation.h:239:41:    expected struct dma_fence *[noderef] <asn:4>*fencep
   include/linux/reservation.h:239:41:    got struct dma_fence [noderef] <asn:4>**<noident>
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
>> include/linux/dma-fence.h:250:25: error: incompatible types in comparison expression (different address spaces)
   include/linux/dma-fence.h:268:30: error: incompatible types in comparison expression (different address spaces)
--
>> drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:37:43: warning: cast removes address space of expression (<asn:2>)
>> drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:37:62: warning: incorrect type in initializer (different address spaces)
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:37:62:    expected void [noderef] <asn:2>*working_address
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:37:62:    got unsigned char [usertype] *
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:67:43: warning: cast removes address space of expression (<asn:2>)
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:67:62: warning: incorrect type in initializer (different address spaces)
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:67:62:    expected void [noderef] <asn:2>*working_address
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:67:62:    got unsigned char [usertype] *
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:97:43: warning: cast removes address space of expression (<asn:2>)
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:97:62: warning: incorrect type in initializer (different address spaces)
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:97:62:    expected void [noderef] <asn:2>*working_address
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:97:62:    got unsigned char [usertype] *
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:127:43: warning: cast removes address space of expression (<asn:2>)
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:127:62: warning: incorrect type in initializer (different address spaces)
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:127:62:    expected void [noderef] <asn:2>*working_address
   drivers/staging/xroeframer/sysfs_xroe_framer_udp.c:127:62:    got unsigned char [usertype] *
--
   include/drm/drm_syncobj.h:120:41: warning: incorrect type in argument 1 (different address spaces)
   include/drm/drm_syncobj.h:120:41:    expected struct dma_fence *[noderef] <asn:4>*fencep
   include/drm/drm_syncobj.h:120:41:    got struct dma_fence **<noident>
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
>> include/linux/dma-fence.h:250:25: error: incompatible types in comparison expression (different address spaces)
   include/linux/dma-fence.h:268:30: error: incompatible types in comparison expression (different address spaces)
--
   include/linux/reservation.h:239:41: warning: incorrect type in argument 1 (different address spaces)
   include/linux/reservation.h:239:41:    expected struct dma_fence *[noderef] <asn:4>*fencep
   include/linux/reservation.h:239:41:    got struct dma_fence [noderef] <asn:4>**<noident>
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
>> include/linux/dma-fence.h:250:25: error: incompatible types in comparison expression (different address spaces)
   include/linux/dma-fence.h:268:30: error: incompatible types in comparison expression (different address spaces)
   include/linux/reservation.h:239:41: warning: incorrect type in argument 1 (different address spaces)
   include/linux/reservation.h:239:41:    expected struct dma_fence *[noderef] <asn:4>*fencep
   include/linux/reservation.h:239:41:    got struct dma_fence [noderef] <asn:4>**<noident>
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
   include/linux/dma-fence.h:250:25: warning: incorrect type in argument 1 (different address spaces)
   include/linux/dma-fence.h:250:25:    expected void const volatile *p
   include/linux/dma-fence.h:250:25:    got struct dma_fence *[noderef] <asn:4>*fencep
>> include/linux/dma-fence.h:250:25: error: incompatible types in comparison expression (different address spaces)
   include/linux/dma-fence.h:268:30: error: incompatible types in comparison expression (different address spaces)
   drivers/gpu/drm/i915/i915_gem.c:1022:33: warning: incorrect type in argument 1 (different address spaces)
   drivers/gpu/drm/i915/i915_gem.c:1022:33:    expected void [noderef] <asn:2>*vaddr
   drivers/gpu/drm/i915/i915_gem.c:1022:33:    got void *[assigned] vaddr
   drivers/gpu/drm/i915/i915_gem.c:1027:34: warning: incorrect type in argument 1 (different address spaces)
   drivers/gpu/drm/i915/i915_gem.c:1027:34:    expected void [noderef] <asn:2>*vaddr
   drivers/gpu/drm/i915/i915_gem.c:1027:34:    got void *[assigned] vaddr
   drivers/gpu/drm/i915/i915_gem.c:1199:33: warning: incorrect type in argument 1 (different address spaces)
   drivers/gpu/drm/i915/i915_gem.c:1199:33:    expected void [noderef] <asn:2>*vaddr
   drivers/gpu/drm/i915/i915_gem.c:1199:33:    got void *[assigned] vaddr
   drivers/gpu/drm/i915/i915_gem.c:1204:34: warning: incorrect type in argument 1 (different address spaces)
   drivers/gpu/drm/i915/i915_gem.c:1204:34:    expected void [noderef] <asn:2>*vaddr
   drivers/gpu/drm/i915/i915_gem.c:1204:34:    got void *[assigned] vaddr
   drivers/gpu/drm/i915/selftests/i915_gem_coherency.c:96:13: warning: incorrect type in assignment (different address spaces)
   drivers/gpu/drm/i915/selftests/i915_gem_coherency.c:96:13:    expected unsigned int *map
   drivers/gpu/drm/i915/selftests/i915_gem_coherency.c:96:13:    got void [noderef] <asn:2>*
   drivers/gpu/drm/i915/selftests/i915_gem_coherency.c:123:13: warning: incorrect type in assignment (different address spaces)
   drivers/gpu/drm/i915/selftests/i915_gem_coherency.c:123:13:    expected unsigned int [usertype] *map
   drivers/gpu/drm/i915/selftests/i915_gem_coherency.c:123:13:    got void [noderef] <asn:2>*

vim +68 drivers/md/linear.c

^1da177e Linus Torvalds 2005-04-16  55  
03a9e24e colyli at suse.de 2017-01-28  56  /*
03a9e24e colyli at suse.de 2017-01-28  57   * In linear_congested() conf->raid_disks is used as a copy of
03a9e24e colyli at suse.de 2017-01-28  58   * mddev->raid_disks to iterate conf->disks[], because conf->raid_disks
03a9e24e colyli at suse.de 2017-01-28  59   * and conf->disks[] are created in linear_conf(), they are always
03a9e24e colyli at suse.de 2017-01-28  60   * consitent with each other, but mddev->raid_disks does not.
03a9e24e colyli at suse.de 2017-01-28  61   */
5c675f83 NeilBrown      2014-12-15  62  static int linear_congested(struct mddev *mddev, int bits)
26be34dc NeilBrown      2006-10-03  63  {
e849b938 NeilBrown      2011-10-11  64  	struct linear_conf *conf;
26be34dc NeilBrown      2006-10-03  65  	int i, ret = 0;
26be34dc NeilBrown      2006-10-03  66  
03a9e24e colyli at suse.de 2017-01-28  67  	rcu_read_lock();
03a9e24e colyli at suse.de 2017-01-28 @68  	conf = rcu_dereference(mddev->private);
af11c397 SandeepKsinha  2009-06-18  69  
03a9e24e colyli at suse.de 2017-01-28  70  	for (i = 0; i < conf->raid_disks && !ret ; i++) {
165125e1 Jens Axboe     2007-07-24  71  		struct request_queue *q = bdev_get_queue(conf->disks[i].rdev->bdev);
dc3b17cc Jan Kara       2017-02-02  72  		ret |= bdi_congested(q->backing_dev_info, bits);
26be34dc NeilBrown      2006-10-03  73  	}
af11c397 SandeepKsinha  2009-06-18  74  
03a9e24e colyli at suse.de 2017-01-28  75  	rcu_read_unlock();
26be34dc NeilBrown      2006-10-03  76  	return ret;
26be34dc NeilBrown      2006-10-03  77  }
26be34dc NeilBrown      2006-10-03  78  

:::::: The code at line 68 was first introduced by commit
:::::: 03a9e24ef2aaa5f1f9837356aed79c860521407a md linear: fix a race between linear_add() and linear_congested()

:::::: TO: colyli at suse.de <colyli@suse.de>
:::::: CC: Shaohua Li <shli@fb.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62097 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181017/fc9c3447/attachment-0001.gz>
