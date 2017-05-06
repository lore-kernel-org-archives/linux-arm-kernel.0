From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 6 May 2017 23:40:07 +0800
Subject: [arm:sa1100 73/112] arch/arm/mach-pxa/colibri-pxa320.c:98:15: error:
 variable 'colibri_pxa320_pcmcia_lookup_table' has initializer but
 incomplete type
Message-ID: <201705062304.0gKtkGzd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git sa1100
head:   5d8c4e81af8e3188608bbf89ee90e6131c588c28
commit: 95cb5c2a96dfbf8ecdc028aaa43461de6d2bcf30 [73/112] ARM: pxa/colibri: switch pcmcia to gpiod APIs
config: arm-pxa_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 95cb5c2a96dfbf8ecdc028aaa43461de6d2bcf30
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

>> arch/arm/mach-pxa/colibri-pxa320.c:98:15: error: variable 'colibri_pxa320_pcmcia_lookup_table' has initializer but incomplete type
    static struct gpiod_lookup_table colibri_pxa320_pcmcia_lookup_table = {
                  ^~~~~~~~~~~~~~~~~~
>> arch/arm/mach-pxa/colibri-pxa320.c:99:2: error: unknown field 'dev_id' specified in initializer
     .dev_id = "pxa2xx-pcmcia",
     ^
>> arch/arm/mach-pxa/colibri-pxa320.c:99:12: warning: excess elements in struct initializer
     .dev_id = "pxa2xx-pcmcia",
               ^~~~~~~~~~~~~~~
   arch/arm/mach-pxa/colibri-pxa320.c:99:12: note: (near initialization for 'colibri_pxa320_pcmcia_lookup_table')
>> arch/arm/mach-pxa/colibri-pxa320.c:100:2: error: unknown field 'table' specified in initializer
     .table = {
     ^
>> arch/arm/mach-pxa/colibri-pxa320.c:100:11: error: extra brace group at end of initializer
     .table = {
              ^
   arch/arm/mach-pxa/colibri-pxa320.c:100:11: note: (near initialization for 'colibri_pxa320_pcmcia_lookup_table')
>> arch/arm/mach-pxa/colibri-pxa320.c:101:3: error: implicit declaration of function 'GPIO_LOOKUP' [-Werror=implicit-function-declaration]
      GPIO_LOOKUP("GPIO", 29, "ready",  GPIO_ACTIVE_HIGH),
      ^~~~~~~~~~~
>> arch/arm/mach-pxa/colibri-pxa320.c:101:37: error: 'GPIO_ACTIVE_HIGH' undeclared here (not in a function)
      GPIO_LOOKUP("GPIO", 29, "ready",  GPIO_ACTIVE_HIGH),
                                        ^~~~~~~~~~~~~~~~
   arch/arm/mach-pxa/colibri-pxa320.c:107:3: error: extra brace group at end of initializer
      { },
      ^
   arch/arm/mach-pxa/colibri-pxa320.c:107:3: note: (near initialization for 'colibri_pxa320_pcmcia_lookup_table')
   arch/arm/mach-pxa/colibri-pxa320.c:100:11: warning: excess elements in struct initializer
     .table = {
              ^
   arch/arm/mach-pxa/colibri-pxa320.c:100:11: note: (near initialization for 'colibri_pxa320_pcmcia_lookup_table')
   arch/arm/mach-pxa/colibri-pxa320.c: In function 'colibri_pxa320_init_pcmcia':
>> arch/arm/mach-pxa/colibri-pxa320.c:113:2: error: implicit declaration of function 'gpiod_add_lookup_table' [-Werror=implicit-function-declaration]
     gpiod_add_lookup_table(&colibri_pxa320_pcmcia_gpio_table);
     ^~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mach-pxa/colibri-pxa320.c:113:26: error: 'colibri_pxa320_pcmcia_gpio_table' undeclared (first use in this function)
     gpiod_add_lookup_table(&colibri_pxa320_pcmcia_gpio_table);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-pxa/colibri-pxa320.c:113:26: note: each undeclared identifier is reported only once for each function it appears in
   arch/arm/mach-pxa/colibri-pxa320.c: At top level:
>> arch/arm/mach-pxa/colibri-pxa320.c:98:34: error: storage size of 'colibri_pxa320_pcmcia_lookup_table' isn't known
    static struct gpiod_lookup_table colibri_pxa320_pcmcia_lookup_table = {
                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-pxa/colibri-pxa320.c:98:34: warning: 'colibri_pxa320_pcmcia_lookup_table' defined but not used [-Wunused-variable]
   cc1: some warnings being treated as errors

vim +/colibri_pxa320_pcmcia_lookup_table +98 arch/arm/mach-pxa/colibri-pxa320.c

    92		GPIO77_GPIO,		/* PRST (RESET GPIO) */
    93		GPIO53_GPIO,		/* PBVD1 */
    94		GPIO79_GPIO,		/* PBVD2 */
    95		GPIO54_GPIO,		/* POE */
    96	};
    97	
  > 98	static struct gpiod_lookup_table colibri_pxa320_pcmcia_lookup_table = {
  > 99		.dev_id = "pxa2xx-pcmcia",
 > 100		.table = {
 > 101			GPIO_LOOKUP("GPIO", 29, "ready",  GPIO_ACTIVE_HIGH),
   102			GPIO_LOOKUP("GPIO", 53, "bvd1",   GPIO_ACTIVE_HIGH),
   103			GPIO_LOOKUP("GPIO", 57, "ppen",   GPIO_ACTIVE_HIGH),
   104			GPIO_LOOKUP("GPIO", 77, "reset",  GPIO_ACTIVE_HIGH),
   105			GPIO_LOOKUP("GPIO", 79, "bvd2",   GPIO_ACTIVE_HIGH),
   106			GPIO_LOOKUP("GPIO", 81, "detect", GPIO_ACTIVE_HIGH),
 > 107			{ },
   108		},
   109	};
   110	
   111	static void colibri_pxa320_init_pcmcia(void)
   112	{
 > 113		gpiod_add_lookup_table(&colibri_pxa320_pcmcia_gpio_table);
   114	}
   115	#else
   116	static mfp_cfg_t colibri_pxa320_evalboard_pin_config[] __initdata = {};

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30525 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170506/4bc67d9f/attachment-0001.gz>
