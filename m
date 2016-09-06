From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 7 Sep 2016 03:29:58 +0800
Subject: [arm:sa1100 33/97] arch/arm/common/sa1111.c:515:19: error: 'irqbase'
 undeclared
Message-ID: <201609070356.QKsjqKNj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git sa1100
head:   8712f29f4497fc83173d512149d3949b6f87e2dd
commit: 31dbff2701e82c42bb210a7e310abe63c0a96c66 [33/97] ARM: sa1111: move irq cleanup to separate function
config: arm-sa1100 (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 31dbff2701e82c42bb210a7e310abe63c0a96c66
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm/common/sa1111.c:36:0:
   arch/arm/common/sa1111.c: In function 'sa1111_remove_irq':
>> arch/arm/common/sa1111.c:515:19: error: 'irqbase' undeclared (first use in this function)
     sa1111_writel(0, irqbase + SA1111_INTEN0);
                      ^
   arch/arm/include/asm/hardware/sa1111.h:32:51: note: in definition of macro 'sa1111_writel'
    #define sa1111_writel(val,addr) __raw_writel(val, addr)
                                                      ^
   arch/arm/common/sa1111.c:515:19: note: each undeclared identifier is reported only once for each function it appears in
     sa1111_writel(0, irqbase + SA1111_INTEN0);
                      ^
   arch/arm/include/asm/hardware/sa1111.h:32:51: note: in definition of macro 'sa1111_writel'
    #define sa1111_writel(val,addr) __raw_writel(val, addr)
                                                      ^
   arch/arm/common/sa1111.c: In function '__sa1111_remove':
>> arch/arm/common/sa1111.c:838:16: warning: unused variable 'irqbase' [-Wunused-variable]
     void __iomem *irqbase = sachip->base + SA1111_INTC;
                   ^

vim +/irqbase +515 arch/arm/common/sa1111.c

   509		return 0;
   510	}
   511	
   512	static void sa1111_remove_irq(struct sa1111 *sachip)
   513	{
   514		/* disable all IRQs */
 > 515		sa1111_writel(0, irqbase + SA1111_INTEN0);
   516		sa1111_writel(0, irqbase + SA1111_INTEN1);
   517		sa1111_writel(0, irqbase + SA1111_WAKEEN0);
   518		sa1111_writel(0, irqbase + SA1111_WAKEEN1);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22808 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/f579dadc/attachment-0001.obj>
