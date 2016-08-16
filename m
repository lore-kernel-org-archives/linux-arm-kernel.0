From: lkp@intel.com (kbuild test robot)
Date: Tue, 16 Aug 2016 08:25:30 +0800
Subject: [PATCH v2] Added perf functionality to mmdc driver
In-Reply-To: <20160815223035.5429-1-zhengyu.shen@nxp.com>
Message-ID: <201608160837.zkvBFWQI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhengyu,

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on v4.8-rc2 next-20160815]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Zhengyu-Shen/Added-perf-functionality-to-mmdc-driver/20160816-063431
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-imx/mmdc.c: In function 'mmdc_pmu_init':
>> arch/arm/mach-imx/mmdc.c:354:30: error: 'CPU_PRI_PERF' undeclared (first use in this function)
     pmu_mmdc->cpu_nb.priority = CPU_PRI_PERF + 1;
                                 ^
   arch/arm/mach-imx/mmdc.c:354:30: note: each undeclared identifier is reported only once for each function it appears in

vim +/CPU_PRI_PERF +354 arch/arm/mach-imx/mmdc.c

   348	
   349		mmdc_num = ida_simple_get(&mmdc_ida, 0, 0, GFP_KERNEL);
   350	
   351		cpumask_set_cpu(smp_processor_id(), &pmu_mmdc->cpu);
   352	
   353		pmu_mmdc->cpu_nb.notifier_call = mmdc_cpu_notifier;
 > 354		pmu_mmdc->cpu_nb.priority = CPU_PRI_PERF + 1;
   355	
   356		pmu_mmdc->dev = dev;
   357		return mmdc_num;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 58520 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160816/4999ba50/attachment-0001.obj>
