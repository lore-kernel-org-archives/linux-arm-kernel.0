From: lkp@intel.com (kbuild test robot)
Date: Thu, 20 Jul 2017 00:09:16 +0800
Subject: [PATCH 7/7] staging: fsl-mc: allow the driver compile multi-arch
In-Reply-To: <20170717132646.3020-8-laurentiu.tudor@nxp.com>
Message-ID: <201707200027.vMmHtTkK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurentiu,

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on v4.13-rc1 next-20170718]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/laurentiu-tudor-nxp-com/staging-fsl-mc-make-the-driver-compile-on-other-architectures/20170718-021715
config: cris-allyesconfig (attached as .config)
compiler: cris-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=cris 

All errors (new ones prefixed by >>):

   In file included from drivers/staging/fsl-mc/bus/fsl-mc-bus.c:21:0:
>> include/linux/msi.h:196:21: fatal error: asm/msi.h: No such file or directory
    #include <asm/msi.h>
                        ^
   compilation terminated.

vim +196 include/linux/msi.h

d9109698 Jiang Liu 2014-11-15  194  
aeeb5965 Jiang Liu 2014-11-15  195  #include <linux/irqhandler.h>
d9109698 Jiang Liu 2014-11-15 @196  #include <asm/msi.h>
d9109698 Jiang Liu 2014-11-15  197  

:::::: The code at line 196 was first introduced by commit
:::::: d9109698be6e7439e6082aa00d79d4556114739b genirq: Introduce msi_domain_alloc/free_irqs()

:::::: TO: Jiang Liu <jiang.liu@linux.intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43210 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170720/1d79ecc5/attachment-0001.gz>
