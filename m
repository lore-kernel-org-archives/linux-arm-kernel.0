From: lkp@intel.com (kbuild test robot)
Date: Fri, 29 Jan 2016 01:33:35 +0800
Subject: [PATCH v2 5/5] arm64/perf: Extend event mask for ARMv8.1
In-Reply-To: <6251e3377ca5d109c1a38ecc07fed50d6cbf5c61.1453992560.git.jglauber@cavium.com>
Message-ID: <201601290124.q5BROUwL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.5-rc1 next-20160128]
[cannot apply to tip/perf/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jan-Glauber/Cavium-ThunderX-PMU-support/20160128-225855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-corgi_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/perf_event_xscale.c: In function 'xscale_map_event':
>> arch/arm/kernel/perf_event_xscale.c:360:9: error: too many arguments to function 'armpmu_map_event'
     return armpmu_map_event(event, &xscale_perf_map,
            ^
   In file included from arch/arm/kernel/perf_event_xscale.c:21:0:
   include/linux/perf/arm_pmu.h:119:5: note: declared here
    int armpmu_map_event(struct perf_event *event,
        ^

vim +/armpmu_map_event +360 arch/arm/kernel/perf_event_xscale.c

43eab878 Will Deacon  2010-11-13  354  		break;
43eab878 Will Deacon  2010-11-13  355  	}
43eab878 Will Deacon  2010-11-13  356  }
43eab878 Will Deacon  2010-11-13  357  
e1f431b5 Mark Rutland 2011-04-28  358  static int xscale_map_event(struct perf_event *event)
e1f431b5 Mark Rutland 2011-04-28  359  {
6dbc0029 Will Deacon  2012-07-29 @360  	return armpmu_map_event(event, &xscale_perf_map,
e1f431b5 Mark Rutland 2011-04-28  361  				&xscale_perf_cache_map, 0xFF);
e1f431b5 Mark Rutland 2011-04-28  362  }
e1f431b5 Mark Rutland 2011-04-28  363  

:::::: The code at line 360 was first introduced by commit
:::::: 6dbc00297095122ea89e016ce6affad0b7c0ddac ARM: perf: prepare for moving CPU PMU code into separate file

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 18550 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/db8caebe/attachment-0001.obj>
