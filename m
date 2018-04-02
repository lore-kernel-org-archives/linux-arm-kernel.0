From: lkp@intel.com (kbuild test robot)
Date: Tue, 3 Apr 2018 02:46:09 +0800
Subject: [PATCH 15/15] ARM: pxa: change SSP DMA channels allocation
In-Reply-To: <20180402142656.26815-16-robert.jarzmik@free.fr>
References: <20180402142656.26815-16-robert.jarzmik@free.fr>
Message-ID: <201804030207.61pqIbzh%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16]
[cannot apply to arm-soc/for-next next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Robert-Jarzmik/ARM-pxa-switch-to-DMA-slave-maps/20180402-233029
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> arch/arm/plat-pxa/ssp.c:19:10: fatal error: mach/audio.h: No such file or directory
    #include <mach/audio.h>
             ^~~~~~~~~~~~~~
   compilation terminated.

vim +19 arch/arm/plat-pxa/ssp.c

  > 19	#include <mach/audio.h>
    20	#include <linux/module.h>
    21	#include <linux/kernel.h>
    22	#include <linux/sched.h>
    23	#include <linux/slab.h>
    24	#include <linux/errno.h>
    25	#include <linux/interrupt.h>
    26	#include <linux/ioport.h>
    27	#include <linux/init.h>
    28	#include <linux/mutex.h>
    29	#include <linux/clk.h>
    30	#include <linux/err.h>
    31	#include <linux/platform_device.h>
    32	#include <linux/spi/pxa2xx_spi.h>
    33	#include <linux/io.h>
    34	#include <linux/of.h>
    35	#include <linux/of_device.h>
    36	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65120 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/9e9f2e74/attachment-0001.gz>
