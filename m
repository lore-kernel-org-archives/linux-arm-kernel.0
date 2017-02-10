From: lkp@intel.com (kbuild test robot)
Date: Fri, 10 Feb 2017 14:18:34 +0800
Subject: [PATCH 4/4] [media] s5p-mfc: Always check and set
 'v4l2_pix_format:field' field
In-Reply-To: <20170209194314.5908-5-thibault.saunier@osg.samsung.com>
Message-ID: <201702101450.t5vJYZRR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thibault,

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.10-rc7 next-20170209]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Thibault-Saunier/exynos-gsc-Use-576p-instead-720p-as-a-threshold-for-colorspaces/20170210-113658
base:   git://linuxtv.org/media_tree.git master
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:28:0:
   drivers/media/platform/s5p-mfc/s5p_mfc_dec.c: In function 'vidioc_try_fmt':
>> drivers/media/platform/s5p-mfc/s5p_mfc_debug.h:25:23: warning: comparison between pointer and integer
      if (mfc_debug_level >= level)   \
                          ^
>> drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:404:3: note: in expansion of macro 'mfc_debug'
      mfc_debug("Not supported field order(%d)\n", pix_mp->field);
      ^~~~~~~~~
>> drivers/media/platform/s5p-mfc/s5p_mfc_debug.h:25:23: warning: comparison with string literal results in unspecified behavior [-Waddress]
      if (mfc_debug_level >= level)   \
                          ^
>> drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:404:3: note: in expansion of macro 'mfc_debug'
      mfc_debug("Not supported field order(%d)\n", pix_mp->field);
      ^~~~~~~~~
>> drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:404:48: error: expected ')' before 'pix_mp'
      mfc_debug("Not supported field order(%d)\n", pix_mp->field);
                                                   ^
   drivers/media/platform/s5p-mfc/s5p_mfc_debug.h:26:32: note: in definition of macro 'mfc_debug'
       printk(KERN_DEBUG "%s:%d: " fmt, \
                                   ^~~
   In file included from include/linux/printk.h:6:0,
                    from include/linux/kernel.h:13,
                    from include/linux/clk.h:16,
                    from drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:14:
   include/linux/kern_levels.h:4:18: warning: format '%s' expects a matching 'char *' argument [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:14:20: note: in expansion of macro 'KERN_SOH'
    #define KERN_DEBUG KERN_SOH "7" /* debug-level messages */
                       ^~~~~~~~
   drivers/media/platform/s5p-mfc/s5p_mfc_debug.h:26:11: note: in expansion of macro 'KERN_DEBUG'
       printk(KERN_DEBUG "%s:%d: " fmt, \
              ^~~~~~~~~~
>> drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:404:3: note: in expansion of macro 'mfc_debug'
      mfc_debug("Not supported field order(%d)\n", pix_mp->field);
      ^~~~~~~~~
   include/linux/kern_levels.h:4:18: warning: format '%d' expects a matching 'int' argument [-Wformat=]
    #define KERN_SOH "\001"  /* ASCII Start Of Header */
                     ^
   include/linux/kern_levels.h:14:20: note: in expansion of macro 'KERN_SOH'
    #define KERN_DEBUG KERN_SOH "7" /* debug-level messages */
                       ^~~~~~~~
   drivers/media/platform/s5p-mfc/s5p_mfc_debug.h:26:11: note: in expansion of macro 'KERN_DEBUG'
       printk(KERN_DEBUG "%s:%d: " fmt, \
              ^~~~~~~~~~
>> drivers/media/platform/s5p-mfc/s5p_mfc_dec.c:404:3: note: in expansion of macro 'mfc_debug'
      mfc_debug("Not supported field order(%d)\n", pix_mp->field);
      ^~~~~~~~~

vim +404 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c

   398		enum v4l2_field field;
   399	
   400		field = f->fmt.pix.field;
   401		if (field == V4L2_FIELD_ANY) {
   402			field = V4L2_FIELD_NONE;
   403		} else if (V4L2_FIELD_NONE != field) {
 > 404			mfc_debug("Not supported field order(%d)\n", pix_mp->field);
   405			return -EINVAL;
   406		}
   407	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45920 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170210/8dd6e8c7/attachment-0001.gz>
