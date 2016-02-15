From: lkp@intel.com (kbuild test robot)
Date: Mon, 15 Feb 2016 17:09:27 +0800
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201602151735.BaFwBMOn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.5-rc4 next-20160215]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Thomas-Petazzoni/dma-mv_xor_v2-new-driver/20160215-160120
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: openrisc-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   In file included from kernel/irq/chip.c:14:0:
>> include/linux/msi.h:174:21: fatal error: asm/msi.h: No such file or directory
   compilation terminated.

vim +174 include/linux/msi.h

c2791b80 Yijing Wang    2014-11-11  168  	void (*teardown_irq)(struct msi_controller *chip, unsigned int irq);
0cbdcfcf Thierry Reding 2013-08-09  169  };
0cbdcfcf Thierry Reding 2013-08-09  170  
f3cf8bb0 Jiang Liu      2014-11-12  171  #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
d9109698 Jiang Liu      2014-11-15  172  
aeeb5965 Jiang Liu      2014-11-15  173  #include <linux/irqhandler.h>
d9109698 Jiang Liu      2014-11-15 @174  #include <asm/msi.h>
d9109698 Jiang Liu      2014-11-15  175  
f3cf8bb0 Jiang Liu      2014-11-12  176  struct irq_domain;
552c494a Marc Zyngier   2015-11-23  177  struct irq_domain_ops;

:::::: The code at line 174 was first introduced by commit
:::::: d9109698be6e7439e6082aa00d79d4556114739b genirq: Introduce msi_domain_alloc/free_irqs()

:::::: TO: Jiang Liu <jiang.liu@linux.intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36865 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160215/c5363463/attachment-0001.obj>
