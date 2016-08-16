From: lkp@intel.com (kbuild test robot)
Date: Tue, 16 Aug 2016 13:13:25 +0800
Subject: [PATCH v1 3/3] PM / AVS: rockchip-cpu-avs: add driver handling
 Rockchip cpu avs
In-Reply-To: <1471315139-28285-4-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <201608161305.FWFbm1Ww%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Finley,

[auto build test ERROR on battery/master]
[also build test ERROR on v4.8-rc2 next-20160815]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Finlye-Xiao/PM-AVS-add-Rockchip-cpu-avs/20160816-105228
base:   git://git.infradead.org/battery-2.6.git master
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   drivers/power/avs/rockchip-cpu-avs.c: In function 'rockchip_cpu_avs_notifier':
>> drivers/power/avs/rockchip-cpu-avs.c:230:10: error: implicit declaration of function 'cpufreq_frequency_get_table' [-Werror=implicit-function-declaration]
     table = cpufreq_frequency_get_table(policy->cpu);
             ^
>> drivers/power/avs/rockchip-cpu-avs.c:230:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     table = cpufreq_frequency_get_table(policy->cpu);
           ^
   cc1: some warnings being treated as errors

vim +/cpufreq_frequency_get_table +230 drivers/power/avs/rockchip-cpu-avs.c

   224		dev = get_cpu_device(policy->cpu);
   225		if (!dev) {
   226			pr_err("cpu%d Failed to get device\n", policy->cpu);
   227			goto out;
   228		}
   229	
 > 230		table = cpufreq_frequency_get_table(policy->cpu);
   231		if (!table) {
   232			pr_err("cpu%d CPUFreq table not found\n", policy->cpu);
   233			goto out;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 58506 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160816/78d6ed26/attachment-0001.obj>
