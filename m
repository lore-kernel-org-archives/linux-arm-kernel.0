From: lkp@intel.com (kbuild test robot)
Date: Tue, 28 Aug 2018 09:23:01 +0800
Subject: [PATCH 8/9] drm/msm/a6xx: Add support for an interconnect path
In-Reply-To: <20180827151112.25211-9-jcrouse@codeaurora.org>
References: <20180827151112.25211-9-jcrouse@codeaurora.org>
Message-ID: <201808280914.OwbuiIYc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jordan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robclark/msm-next]
[also build test ERROR on v4.19-rc1 next-20180827]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jordan-Crouse/Add-interconnect-support-bindings-for-A630-GPU/20180828-004407
base:   git://people.freedesktop.org/~robclark/linux msm-next
config: arm-defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/msm/adreno/adreno_gpu.h:25:0,
                    from drivers/gpu/drm/msm/adreno/adreno_device.c:20:
>> drivers/gpu/drm/msm/msm_gpu.h:23:10: fatal error: linux/interconnect.h: No such file or directory
    #include <linux/interconnect.h>
             ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> drivers/gpu/drm/msm/adreno/adreno_gpu.c:24:10: fatal error: linux/interconnect.h: No such file or directory
    #include <linux/interconnect.h>
             ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> drivers/gpu/drm/msm/adreno/a6xx_gmu.c:7:10: fatal error: linux/interconnect.h: No such file or directory
    #include <linux/interconnect.h>
             ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +23 drivers/gpu/drm/msm/msm_gpu.h

    20	
    21	#include <linux/clk.h>
    22	#include <linux/regulator/consumer.h>
  > 23	#include <linux/interconnect.h>
    24	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43978 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180828/84a48c24/attachment-0001.gz>
