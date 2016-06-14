From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 14 Jun 2016 12:41:25 +0800
Subject: [arm-platforms:irq/irqchip-4.8 11/15]
 drivers/irqchip/irq-gic-v3-its.c:958:3: error: implicit declaration of
 function 'its_write_baser_cache'
Message-ID: <201606141224.l77YhXRd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irqchip-4.8
head:   3faf24ea894a34887c0ca412f1643540251b9d82
commit: 2d81d425b6d5cc2262912cce9f9ec7f706a3ea65 [11/15] irqchip/gicv3-its: Introduce two helper functions for accessing BASERn
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2d81d425b6d5cc2262912cce9f9ec7f706a3ea65
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the arm-platforms/irq/irqchip-4.8 HEAD 3faf24ea894a34887c0ca412f1643540251b9d82 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3-its.c: In function 'its_alloc_tables':
>> drivers/irqchip/irq-gic-v3-its.c:958:3: error: implicit declaration of function 'its_write_baser_cache' [-Werror=implicit-function-declaration]
      its_write_baser_cache(its, baser, val);
      ^
   drivers/irqchip/irq-gic-v3-its.c: At top level:
   drivers/irqchip/irq-gic-v3-its.c:834:13: warning: 'its_write_baser' defined but not used [-Wunused-function]
    static void its_write_baser(struct its_node *its, struct its_baser *baser,
                ^
   cc1: some warnings being treated as errors

vim +/its_write_baser_cache +958 drivers/irqchip/irq-gic-v3-its.c

   952				val |= GITS_BASER_PAGE_SIZE_64K;
   953				break;
   954			}
   955	
   956			val |= alloc_pages - 1;
   957	
 > 958			its_write_baser_cache(its, baser, val);
   959			tmp = baser->val;
   960	
   961			if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25987 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160614/a9ff4a7e/attachment-0001.obj>
