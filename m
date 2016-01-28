From: lkp@intel.com (kbuild test robot)
Date: Fri, 29 Jan 2016 00:14:12 +0800
Subject: [PATCH v2 5/5] arm64/perf: Extend event mask for ARMv8.1
In-Reply-To: <6251e3377ca5d109c1a38ecc07fed50d6cbf5c61.1453992560.git.jglauber@cavium.com>
Message-ID: <201601290024.hpLX77Id%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.5-rc1 next-20160128]
[cannot apply to tip/perf/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jan-Glauber/Cavium-ThunderX-PMU-support/20160128-225855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-imx_v6_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/perf_event_v6.c: In function 'armv6_map_event':
>> arch/arm/kernel/perf_event_v6.c:483:9: error: too many arguments to function 'armpmu_map_event'
     return armpmu_map_event(event, &armv6_perf_map,
            ^
   In file included from arch/arm/kernel/perf_event_v6.c:39:0:
   include/linux/perf/arm_pmu.h:119:5: note: declared here
    int armpmu_map_event(struct perf_event *event,
        ^
   arch/arm/kernel/perf_event_v6.c: In function 'armv6mpcore_map_event':
   arch/arm/kernel/perf_event_v6.c:533:9: error: too many arguments to function 'armpmu_map_event'
     return armpmu_map_event(event, &armv6mpcore_perf_map,
            ^
   In file included from arch/arm/kernel/perf_event_v6.c:39:0:
   include/linux/perf/arm_pmu.h:119:5: note: declared here
    int armpmu_map_event(struct perf_event *event,
        ^
--
   arch/arm/kernel/perf_event_v7.c: In function 'armv7_a8_map_event':
>> arch/arm/kernel/perf_event_v7.c:1111:9: error: too many arguments to function 'armpmu_map_event'
     return armpmu_map_event(event, &armv7_a8_perf_map,
            ^
   In file included from arch/arm/kernel/perf_event_v7.c:28:0:
   include/linux/perf/arm_pmu.h:119:5: note: declared here
    int armpmu_map_event(struct perf_event *event,
        ^
   arch/arm/kernel/perf_event_v7.c: In function 'armv7_a9_map_event':
   arch/arm/kernel/perf_event_v7.c:1117:9: error: too many arguments to function 'armpmu_map_event'
     return armpmu_map_event(event, &armv7_a9_perf_map,
            ^
   In file included from arch/arm/kernel/perf_event_v7.c:28:0:
   include/linux/perf/arm_pmu.h:119:5: note: declared here
    int armpmu_map_event(struct perf_event *event,
        ^
   arch/arm/kernel/perf_event_v7.c: In function 'armv7_a5_map_event':
   arch/arm/kernel/perf_event_v7.c:1123:9: error: too many arguments to function 'armpmu_map_event'
     return armpmu_map_event(event, &armv7_a5_perf_map,
            ^
   In file included from arch/arm/kernel/perf_event_v7.c:28:0:
   include/linux/perf/arm_pmu.h:119:5: note: declared here
    int armpmu_map_event(struct perf_event *event,
        ^
   arch/arm/kernel/perf_event_v7.c: In function 'armv7_a15_map_event':
   arch/arm/kernel/perf_event_v7.c:1129:9: error: too many arguments to function 'armpmu_map_event'
     return armpmu_map_event(event, &armv7_a15_perf_map,
            ^
   In file included from arch/arm/kernel/perf_event_v7.c:28:0:
   include/linux/perf/arm_pmu.h:119:5: note: declared here
    int armpmu_map_event(struct perf_event *event,
        ^
   arch/arm/kernel/perf_event_v7.c: In function 'armv7_a7_map_event':
   arch/arm/kernel/perf_event_v7.c:1135:9: error: too many arguments to function 'armpmu_map_event'
     return armpmu_map_event(event, &armv7_a7_perf_map,
            ^
   In file included from arch/arm/kernel/perf_event_v7.c:28:0:
   include/linux/perf/arm_pmu.h:119:5: note: declared here
    int armpmu_map_event(struct perf_event *event,
        ^
   arch/arm/kernel/perf_event_v7.c: In function 'armv7_a12_map_event':
   arch/arm/kernel/perf_event_v7.c:1141:9: error: too many arguments to function 'armpmu_map_event'
     return armpmu_map_event(event, &armv7_a12_perf_map,
            ^
   In file included from arch/arm/kernel/perf_event_v7.c:28:0:
   include/linux/perf/arm_pmu.h:119:5: note: declared here
    int armpmu_map_event(struct perf_event *event,
        ^
   arch/arm/kernel/perf_event_v7.c: In function 'krait_map_event':
   arch/arm/kernel/perf_event_v7.c:1147:9: error: too many arguments to function 'armpmu_map_event'
     return armpmu_map_event(event, &krait_perf_map,
            ^
   In file included from arch/arm/kernel/perf_event_v7.c:28:0:
   include/linux/perf/arm_pmu.h:119:5: note: declared here
    int armpmu_map_event(struct perf_event *event,
        ^
   arch/arm/kernel/perf_event_v7.c: In function 'krait_map_event_no_branch':
   arch/arm/kernel/perf_event_v7.c:1153:9: error: too many arguments to function 'armpmu_map_event'
     return armpmu_map_event(event, &krait_perf_map_no_branch,
            ^
   In file included from arch/arm/kernel/perf_event_v7.c:28:0:
   include/linux/perf/arm_pmu.h:119:5: note: declared here
    int armpmu_map_event(struct perf_event *event,
        ^
   arch/arm/kernel/perf_event_v7.c: In function 'scorpion_map_event':
   arch/arm/kernel/perf_event_v7.c:1159:9: error: too many arguments to function 'armpmu_map_event'
     return armpmu_map_event(event, &scorpion_perf_map,
            ^
   In file included from arch/arm/kernel/perf_event_v7.c:28:0:
   include/linux/perf/arm_pmu.h:119:5: note: declared here
    int armpmu_map_event(struct perf_event *event,
        ^

vim +/armpmu_map_event +483 arch/arm/kernel/perf_event_v6.c

43eab878 Will Deacon  2010-11-13  477  	armv6_pmcr_write(val);
0f78d2d5 Mark Rutland 2011-04-28  478  	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
43eab878 Will Deacon  2010-11-13  479  }
43eab878 Will Deacon  2010-11-13  480  
e1f431b5 Mark Rutland 2011-04-28  481  static int armv6_map_event(struct perf_event *event)
e1f431b5 Mark Rutland 2011-04-28  482  {
6dbc0029 Will Deacon  2012-07-29 @483  	return armpmu_map_event(event, &armv6_perf_map,
e1f431b5 Mark Rutland 2011-04-28  484  				&armv6_perf_cache_map, 0xFF);
e1f431b5 Mark Rutland 2011-04-28  485  }
e1f431b5 Mark Rutland 2011-04-28  486  

:::::: The code at line 483 was first introduced by commit
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
Size: 29108 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/982f6557/attachment-0001.obj>
