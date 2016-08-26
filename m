From: lkp@intel.com (kbuild test robot)
Date: Sat, 27 Aug 2016 05:29:51 +0800
Subject: [PATCH v5 10/16] timer: Export next wake up of a CPU
In-Reply-To: <1472242678-33700-11-git-send-email-lina.iyer@linaro.org>
Message-ID: <201608270514.ln0xl3Ba%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lina,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.8-rc3 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Lina-Iyer/PM-SoC-idle-support-using-PM-domains/20160827-042847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: m68k-sun3_defconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All errors (new ones prefixed by >>):

   In file included from fs/proc/stat.c:13:0:
   include/linux/tick.h: In function 'tick_nohz_get_next_wakeup':
>> include/linux/tick.h:138:9: error: 'tick_next_period' undeclared (first use in this function)
     return tick_next_period;
            ^
   include/linux/tick.h:138:9: note: each undeclared identifier is reported only once for each function it appears in

vim +/tick_next_period +138 include/linux/tick.h

   132	
   133		return len;
   134	}
   135	
   136	static inline ktime_t tick_nohz_get_next_wakeup(int cpu)
   137	{
 > 138		return tick_next_period;
   139	}
   140	
   141	static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 11444 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/90d3c0db/attachment-0001.obj>
