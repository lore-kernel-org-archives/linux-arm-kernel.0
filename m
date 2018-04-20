From: lkp@intel.com (kbuild test robot)
Date: Fri, 20 Apr 2018 09:44:18 +0800
Subject: [PATCH v5 11/23] ASoC: qdsp6: q6adm: Add q6adm driver
In-Reply-To: <20180418153157.1960-12-srinivas.kandagatla@linaro.org>
References: <20180418153157.1960-12-srinivas.kandagatla@linaro.org>
Message-ID: <201804200913.D48SnpbP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

I love your patch! Yet something to improve:

[auto build test ERROR on asoc/for-next]
[also build test ERROR on v4.17-rc1 next-20180419]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/srinivas-kandagatla-linaro-org/ASoC-qcom-Add-support-to-QDSP-based-Audio/20180419-212438
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/srinivas-kandagatla-linaro-org/ASoC-qcom-Add-support-to-QDSP-based-Audio/20180419-212438 HEAD b636a6bdb47d4dfaa6bc43f2ef431f5426b51581 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> sound/soc/qcom/qdsp6/q6adm.c:21:10: fatal error: q6core.h: No such file or directory
    #include "q6core.h"
             ^~~~~~~~~~
   compilation terminated.

vim +21 sound/soc/qcom/qdsp6/q6adm.c

     4	
     5	#include <linux/slab.h>
     6	#include <linux/wait.h>
     7	#include <linux/kernel.h>
     8	#include <linux/device.h>
     9	#include <linux/module.h>
    10	#include <linux/sched.h>
    11	#include <linux/jiffies.h>
    12	#include <linux/of.h>
    13	#include <linux/of_platform.h>
    14	#include <linux/kref.h>
    15	#include <linux/wait.h>
    16	#include <linux/soc/qcom/apr.h>
    17	#include <linux/platform_device.h>
    18	#include <sound/asound.h>
    19	#include "q6adm.h"
    20	#include "q6afe.h"
  > 21	#include "q6core.h"
    22	#include "q6dsp-errno.h"
    23	#include "q6dsp-common.h"
    24	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64548 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180420/626cb309/attachment-0001.gz>
