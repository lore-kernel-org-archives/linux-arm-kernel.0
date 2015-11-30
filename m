From: lkp@intel.com (kbuild test robot)
Date: Mon, 30 Nov 2015 14:54:32 +0800
Subject: [PATCH V5 04/26] coresight: etm3x: splitting struct etm_drvdata
In-Reply-To: <1448849687-5724-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <201511301448.IIogN7Qo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

[auto build test ERROR on: tip/perf/core]
[also build test ERROR on: v4.4-rc3 next-20151127]

url:    https://github.com/0day-ci/linux/commits/Mathieu-Poirier/Coresight-integration-with-perf/20151130-102706
config: arm-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Mathieu-Poirier/Coresight-integration-with-perf/20151130-102706 HEAD c898ed8b47ed7662cd702f15ed57c520a826fbfb builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from arch/arm/include/asm/bug.h:62:0,
                    from arch/arm/include/asm/div64.h:63,
                    from include/linux/kernel.h:136,
                    from drivers/hwtracing/coresight/coresight-etm3x.c:13:
   drivers/hwtracing/coresight/coresight-etm3x.c: In function 'etm_disable_hw':
>> drivers/hwtracing/coresight/coresight-etm3x.c:387:20: error: 'config' undeclared (first use in this function)
     if (WARN_ON_ONCE(!config))
                       ^
   include/asm-generic/bug.h:111:27: note: in definition of macro 'WARN_ON_ONCE'
     int __ret_warn_once = !!(condition);   \
                              ^
   drivers/hwtracing/coresight/coresight-etm3x.c:387:20: note: each undeclared identifier is reported only once for each function it appears in
     if (WARN_ON_ONCE(!config))
                       ^
   include/asm-generic/bug.h:111:27: note: in definition of macro 'WARN_ON_ONCE'
     int __ret_warn_once = !!(condition);   \
                              ^

vim +/config +387 drivers/hwtracing/coresight/coresight-etm3x.c

   381	
   382	static void etm_disable_hw(void *info)
   383	{
   384		int i;
   385		struct etm_drvdata *drvdata = info;
   386	
 > 387		if (WARN_ON_ONCE(!config))
   388			return;
   389	
   390		CS_UNLOCK(drvdata->base);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53921 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/67d07710/attachment-0001.obj>
