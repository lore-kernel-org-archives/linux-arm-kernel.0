From: lkp@intel.com (kbuild test robot)
Date: Thu, 3 Nov 2016 22:41:01 +0800
Subject: [PATCH v2 1/2] PM/devfreq: add suspend frequency support
In-Reply-To: <1478153770-8433-2-git-send-email-hl@rock-chips.com>
Message-ID: <201611032234.VsTMOxrp%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc3 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lin-Huang/set-specific-ddr-frequency-when-stop-ddr-dvfs/20161103-142055
config: x86_64-randconfig-x015-201644 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/devfreq/devfreq.c: In function 'devfreq_monitor_suspend':
>> drivers/devfreq/devfreq.c:368:3: error: too many arguments to function 'update_devfreq'
      update_devfreq(devfreq, devfreq->suspend_freq);
      ^~~~~~~~~~~~~~
   drivers/devfreq/devfreq.c:228:5: note: declared here
    int update_devfreq(struct devfreq *devfreq)
        ^~~~~~~~~~~~~~

vim +/update_devfreq +368 drivers/devfreq/devfreq.c

   362		if (devfreq->stop_polling) {
   363			mutex_unlock(&devfreq->lock);
   364			return;
   365		}
   366	
   367		if (devfreq->suspend_freq)
 > 368			update_devfreq(devfreq, devfreq->suspend_freq);
   369		else
   370			devfreq_update_status(devfreq, devfreq->previous_freq);
   371		devfreq->stop_polling = true;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23592 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161103/9251898a/attachment-0001.gz>
