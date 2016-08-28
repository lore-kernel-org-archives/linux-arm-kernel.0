From: lkp@intel.com (kbuild test robot)
Date: Sun, 28 Aug 2016 11:03:42 +0800
Subject: [PATCH v7 8/8] drm/rockchip: Add dmc notifier in vop driver
In-Reply-To: <1471836984-6316-9-git-send-email-hl@rock-chips.com>
Message-ID: <201608281114.LWiYO8yW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

[auto build test ERROR on rockchip/for-next]
[cannot apply to v4.8-rc3 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Lin-Huang/rk3399-support-ddr-frequency-scaling/20160822-114057
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/rockchip/rockchip_drm_vop.c:16:0:
>> include/linux/devfreq-event.h:190:21: error: redefinition of 'devfreq_event_get_drvdata'
    static inline void *devfreq_event_get_drvdata(struct devfreq_event_dev *edev)
                        ^
   include/linux/devfreq-event.h:151:21: note: previous definition of 'devfreq_event_get_drvdata' was here
    static inline void *devfreq_event_get_drvdata(struct devfreq_event_dev *edev)
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
Size: 38554 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160828/610ad3e2/attachment-0001.obj>
