From: lkp@intel.com (kbuild test robot)
Date: Wed, 10 Aug 2016 13:28:25 +0800
Subject: [PATCH v5 8/8] drm/rockchip: Add dmc notifier in vop driver
In-Reply-To: <1470799604-12877-9-git-send-email-hl@rock-chips.com>
Message-ID: <201608101344.xaQBXfSX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

[auto build test ERROR on v4.8-rc1]
[also build test ERROR on next-20160809]
[cannot apply to rockchip/for-next devfreq/for-rafael linux/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lin-Huang/rk3399-support-ddr-frequency-scaling/20160810-114433
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/rockchip/rockchip_drm_vop.c:16:0:
>> include/linux/devfreq-event.h:190:21: error: redefinition of 'devfreq_event_get_drvdata'
    static inline void *devfreq_event_get_drvdata(struct devfreq_event_dev *edev)
                        ^
   include/linux/devfreq-event.h:151:21: note: previous definition of 'devfreq_event_get_drvdata' was here
    static inline void *devfreq_event_get_drvdata(struct devfreq_event_dev *edev)
                        ^
   drivers/gpu/drm/rockchip/rockchip_drm_vop.c: In function 'vop_bind':
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1586:5: error: 'struct vop' has no member named 'psr_enabled'
     vop->psr_enabled = false;
        ^
   In file included from include/linux/kobject.h:29:0,
                    from include/linux/device.h:17,
                    from include/linux/devfreq.h:16,
                    from drivers/gpu/drm/rockchip/rockchip_drm_vop.c:15:
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1587:24: error: 'struct vop' has no member named 'psr_work'
     INIT_DELAYED_WORK(&vop->psr_work, vop_psr_work);
                           ^
   include/linux/workqueue.h:216:16: note: in definition of macro '__INIT_WORK'
      __init_work((_work), _onstack);    \
                   ^
>> include/linux/workqueue.h:231:3: note: in expansion of macro 'INIT_WORK'
      INIT_WORK(&(_work)->work, (_func));   \
      ^
>> include/linux/workqueue.h:247:2: note: in expansion of macro '__INIT_DELAYED_WORK'
     __INIT_DELAYED_WORK(_work, _func, 0)
     ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1587:2: note: in expansion of macro 'INIT_DELAYED_WORK'
     INIT_DELAYED_WORK(&vop->psr_work, vop_psr_work);
     ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1587:24: error: 'struct vop' has no member named 'psr_work'
     INIT_DELAYED_WORK(&vop->psr_work, vop_psr_work);
                           ^
   include/linux/workqueue.h:217:4: note: in definition of macro '__INIT_WORK'
      (_work)->data = (atomic_long_t) WORK_DATA_INIT(); \
       ^
>> include/linux/workqueue.h:231:3: note: in expansion of macro 'INIT_WORK'
      INIT_WORK(&(_work)->work, (_func));   \
      ^
>> include/linux/workqueue.h:247:2: note: in expansion of macro '__INIT_DELAYED_WORK'
     __INIT_DELAYED_WORK(_work, _func, 0)
     ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1587:2: note: in expansion of macro 'INIT_DELAYED_WORK'
     INIT_DELAYED_WORK(&vop->psr_work, vop_psr_work);
     ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1587:24: error: 'struct vop' has no member named 'psr_work'
     INIT_DELAYED_WORK(&vop->psr_work, vop_psr_work);
                           ^
   include/linux/workqueue.h:218:20: note: in definition of macro '__INIT_WORK'
      INIT_LIST_HEAD(&(_work)->entry);   \
                       ^
>> include/linux/workqueue.h:231:3: note: in expansion of macro 'INIT_WORK'
      INIT_WORK(&(_work)->work, (_func));   \
      ^
>> include/linux/workqueue.h:247:2: note: in expansion of macro '__INIT_DELAYED_WORK'
     __INIT_DELAYED_WORK(_work, _func, 0)
     ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1587:2: note: in expansion of macro 'INIT_DELAYED_WORK'
     INIT_DELAYED_WORK(&vop->psr_work, vop_psr_work);
     ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1587:24: error: 'struct vop' has no member named 'psr_work'
     INIT_DELAYED_WORK(&vop->psr_work, vop_psr_work);
                           ^
   include/linux/workqueue.h:219:4: note: in definition of macro '__INIT_WORK'
      (_work)->func = (_func);    \
       ^
>> include/linux/workqueue.h:231:3: note: in expansion of macro 'INIT_WORK'
      INIT_WORK(&(_work)->work, (_func));   \
      ^
>> include/linux/workqueue.h:247:2: note: in expansion of macro '__INIT_DELAYED_WORK'
     __INIT_DELAYED_WORK(_work, _func, 0)
     ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1587:2: note: in expansion of macro 'INIT_DELAYED_WORK'
     INIT_DELAYED_WORK(&vop->psr_work, vop_psr_work);
     ^
>> drivers/gpu/drm/rockchip/rockchip_drm_vop.c:1587:36: error: 'vop_psr_work' undeclared (first use in this function)
     INIT_DELAYED_WORK(&vop->psr_work, vop_psr_work);
                                       ^
   include/linux/workqueue.h:219:20: note: in definition of macro '__INIT_WORK'
      (_work)->func = (_func);    \
                       ^
>> include/linux/workqueue.h:231:3: note: in expansion of macro 'INIT_WORK'
      INIT_WORK(&(_work)->work, (_func));   \
      ^

vim +/devfreq_event_get_drvdata +190 include/linux/devfreq-event.h

f262f28c Chanwoo Choi 2015-01-26  184  
f262f28c Chanwoo Choi 2015-01-26  185  static inline void devm_devfreq_event_remove_edev(struct device *dev,
f262f28c Chanwoo Choi 2015-01-26  186  					struct devfreq_event_dev *edev)
f262f28c Chanwoo Choi 2015-01-26  187  {
f262f28c Chanwoo Choi 2015-01-26  188  }
f262f28c Chanwoo Choi 2015-01-26  189  
f262f28c Chanwoo Choi 2015-01-26 @190  static inline void *devfreq_event_get_drvdata(struct devfreq_event_dev *edev)
f262f28c Chanwoo Choi 2015-01-26  191  {
f262f28c Chanwoo Choi 2015-01-26  192  	return NULL;
f262f28c Chanwoo Choi 2015-01-26  193  }

:::::: The code at line 190 was first introduced by commit
:::::: f262f28c147051e7aa6daaf4fb5996833ffadff4 PM / devfreq: event: Add devfreq_event class

:::::: TO: Chanwoo Choi <cw00.choi@samsung.com>
:::::: CC: MyungJoo Ham <myungjoo.ham@samsung.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 38547 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160810/52cc3cbf/attachment-0001.obj>
