From: lkp@intel.com (kbuild test robot)
Date: Sat, 27 Aug 2016 07:10:08 +0800
Subject: [PATCH v5 11/16] PM / cpu_domains: Add PM Domain governor for CPUs
In-Reply-To: <1472242678-33700-12-git-send-email-lina.iyer@linaro.org>
Message-ID: <201608270733.QrApGubQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lina,

[auto build test WARNING on pm/linux-next]
[also build test WARNING on v4.8-rc3 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Lina-Iyer/PM-SoC-idle-support-using-PM-domains/20160827-042847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-s0-201634 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from drivers/base/power/cpu_domains.c:25:0:
   include/linux/tick.h: In function 'tick_nohz_get_next_wakeup':
   include/linux/tick.h:138:9: error: 'tick_next_period' undeclared (first use in this function)
     return tick_next_period;
            ^~~~~~~~~~~~~~~~
   include/linux/tick.h:138:9: note: each undeclared identifier is reported only once for each function it appears in
>> include/linux/tick.h:139:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +139 include/linux/tick.h

4f86d3a8 Len Brown                     2007-10-03  132  
4f86d3a8 Len Brown                     2007-10-03  133  	return len;
4f86d3a8 Len Brown                     2007-10-03  134  }
4fad5e09 Lina Iyer                     2016-08-26  135  
4fad5e09 Lina Iyer                     2016-08-26  136  static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
4fad5e09 Lina Iyer                     2016-08-26  137  {
4fad5e09 Lina Iyer                     2016-08-26 @138  	return tick_next_period;
4fad5e09 Lina Iyer                     2016-08-26 @139  }
4fad5e09 Lina Iyer                     2016-08-26  140  
8083e4ad venkatesh.pallipadi at intel.com 2008-08-04  141  static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
0224cf4c Arjan van de Ven              2010-05-09  142  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }

:::::: The code at line 139 was first introduced by commit
:::::: 4fad5e091fe06e14a8258812e6df31f1fbb69d7f timer: Export next wake up of a CPU

:::::: TO: Lina Iyer <lina.iyer@linaro.org>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25925 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/7fc905d0/attachment-0001.obj>
