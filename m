From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 15 Aug 2017 09:59:17 +0800
Subject: [arm:sa1100 76/115] arch/arm/mach-pxa/colibri-pxa320.c:114:26:
 error: 'colibri_pxa320_pcmcia_gpio_table' undeclared
Message-ID: <201708150915.4jZMld7q%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
head:   3d6038e201fa4192ee92de46a6edcc86985139a8
commit: 573e68ae78528ccb1cc2f836be92f4640c630d24 [76/115] ARM: pxa/colibri: switch pcmcia to gpiod APIs
config: arm-pxa_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 573e68ae78528ccb1cc2f836be92f4640c630d24
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-pxa/colibri-pxa320.c: In function 'colibri_pxa320_init_pcmcia':
>> arch/arm/mach-pxa/colibri-pxa320.c:114:26: error: 'colibri_pxa320_pcmcia_gpio_table' undeclared (first use in this function)
     gpiod_add_lookup_table(&colibri_pxa320_pcmcia_gpio_table);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-pxa/colibri-pxa320.c:114:26: note: each undeclared identifier is reported only once for each function it appears in
   At top level:
   arch/arm/mach-pxa/colibri-pxa320.c:99:34: warning: 'colibri_pxa320_pcmcia_lookup_table' defined but not used [-Wunused-variable]
    static struct gpiod_lookup_table colibri_pxa320_pcmcia_lookup_table = {
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/colibri_pxa320_pcmcia_gpio_table +114 arch/arm/mach-pxa/colibri-pxa320.c

   111	
   112	static void colibri_pxa320_init_pcmcia(void)
   113	{
 > 114		gpiod_add_lookup_table(&colibri_pxa320_pcmcia_gpio_table);
   115	}
   116	#else
   117	static mfp_cfg_t colibri_pxa320_evalboard_pin_config[] __initdata = {};
   118	static void colibri_pxa320_init_pcmcia(void)
   119	{
   120	}
   121	#endif
   122	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31065 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170815/ed5caa17/attachment-0001.gz>
