From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 14 Sep 2016 02:12:30 +0800
Subject: [arm:sa1100 80/81] arch/arm/mach-pxa/mainstone.c:560: undefined
 reference to `gpio_reg_init'
Message-ID: <201609140228.hC8MtpFb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
head:   36b075e9681a293ef57aaa107ab394bc879a0807
commit: 4c76c25bd4f755e2302807f99b75ff9954c036d1 [80/81] ARM: pxa/mainstone: convert PCMCIA to use MAX1600 driver and gpiod APIs
config: arm-mainstone_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4c76c25bd4f755e2302807f99b75ff9954c036d1
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-pxa/built-in.o: In function `mainstone_init':
>> arch/arm/mach-pxa/mainstone.c:560: undefined reference to `gpio_reg_init'
   arch/arm/mach-pxa/mainstone.c:563: undefined reference to `gpio_reg_init'

vim +560 arch/arm/mach-pxa/mainstone.c

   554	{
   555		int SW7 = 0;  /* FIXME: get from SCR (Mst doc section 3.2.1.1) */
   556	
   557		pxa2xx_mfp_config(ARRAY_AND_SIZE(mainstone_pin_config));
   558	
   559		/* Register board control register(s) as GPIOs */
 > 560		gpio_reg_init(NULL, (void __iomem *)&MST_PCMCIA0, -1, 11,
   561			      "mst-pcmcia0", MST_PCMCIA_INPUTS, 0, NULL,
   562			      NULL, mst_pcmcia0_irqs);
   563		gpio_reg_init(NULL, (void __iomem *)&MST_PCMCIA1, -1, 11,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 12287 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160914/c8dff7fd/attachment.obj>
