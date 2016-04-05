From: lkp@intel.com (kbuild test robot)
Date: Wed, 6 Apr 2016 05:49:15 +0800
Subject: [PATCH] arm: omap2: remove redundant multiplatform checks
In-Reply-To: <1459886971-32723-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
Message-ID: <201604060526.ouhQYqrT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonas,

[auto build test ERROR on arm-soc/for-next]
[also build test ERROR on v4.6-rc2 next-20160405]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jonas-Rabenstein/arm-omap2-remove-redundant-multiplatform-checks/20160406-041516
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm/mach-omap2/usb-host.c:33:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/usb-host.c: In function 'usbhs_init':
>> arch/arm/mach-omap2/usb-host.c:295:2: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap34xx()) {
     ^
>> arch/arm/mach-omap2/usb-host.c:299:21: error: 'OMAP3430_REV_ES2_1' undeclared (first use in this function)
      if (omap_rev() <= OMAP3430_REV_ES2_1)
                        ^
   arch/arm/mach-omap2/usb-host.c:299:21: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors
--
   In file included from arch/arm/mach-omap2/twl-common.c:31:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
--
   In file included from arch/arm/mach-omap2/id.c:34:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/id.c: In function 'omap_type':
>> arch/arm/mach-omap2/id.c:60:2: error: implicit declaration of function 'soc_is_omap24xx' [-Werror=implicit-function-declaration]
     if (soc_is_omap24xx()) {
     ^
>> arch/arm/mach-omap2/id.c:66:2: error: implicit declaration of function 'soc_is_omap34xx' [-Werror=implicit-function-declaration]
     } else if (soc_is_omap34xx()) {
     ^
   arch/arm/mach-omap2/id.c: At top level:
>> arch/arm/mach-omap2/id.c:148:1: warning: data definition has no type or storage class
    omap_device_initcall(omap_feed_randpool);
    ^
>> arch/arm/mach-omap2/id.c:148:1: error: type defaults to 'int' in declaration of 'omap_device_initcall' [-Werror=implicit-int]
>> arch/arm/mach-omap2/id.c:148:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/id.c: In function 'omap3_cpuinfo':
>> arch/arm/mach-omap2/id.c:221:2: error: implicit declaration of function 'soc_is_omap3630' [-Werror=implicit-function-declaration]
     if (soc_is_omap3630()) {
     ^
>> arch/arm/mach-omap2/id.c:224:3: error: implicit declaration of function 'omap3_has_sgx' [-Werror=implicit-function-declaration]
      cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
      ^
>> arch/arm/mach-omap2/id.c:233:2: error: implicit declaration of function 'omap3_has_iva' [-Werror=implicit-function-declaration]
     } else if (omap3_has_iva() && omap3_has_sgx()) {
     ^
>> arch/arm/mach-omap2/id.c:249:2: error: implicit declaration of function 'omap3_has_l2cache' [-Werror=implicit-function-declaration]
     OMAP3_SHOW_FEATURE(l2cache);
     ^
>> arch/arm/mach-omap2/id.c:252:2: error: implicit declaration of function 'omap3_has_neon' [-Werror=implicit-function-declaration]
     OMAP3_SHOW_FEATURE(neon);
     ^
>> arch/arm/mach-omap2/id.c:253:2: error: implicit declaration of function 'omap3_has_isp' [-Werror=implicit-function-declaration]
     OMAP3_SHOW_FEATURE(isp);
     ^
>> arch/arm/mach-omap2/id.c:254:2: error: implicit declaration of function 'omap3_has_192mhz_clk' [-Werror=implicit-function-declaration]
     OMAP3_SHOW_FEATURE(192mhz_clk);
     ^
   arch/arm/mach-omap2/id.c: In function 'omap3xxx_check_features':
>> arch/arm/mach-omap2/id.c:262:20: error: 'OMAP3_HAS_L2CACHE' undeclared (first use in this function)
      omap_features |= OMAP3_HAS_ ##feat;   \
                       ^
>> arch/arm/mach-omap2/id.c:273:2: note: in expansion of macro 'OMAP3_CHECK_FEATURE'
     OMAP3_CHECK_FEATURE(status, L2CACHE);
     ^
   arch/arm/mach-omap2/id.c:262:20: note: each undeclared identifier is reported only once for each function it appears in
      omap_features |= OMAP3_HAS_ ##feat;   \
                       ^
>> arch/arm/mach-omap2/id.c:273:2: note: in expansion of macro 'OMAP3_CHECK_FEATURE'
     OMAP3_CHECK_FEATURE(status, L2CACHE);
     ^
>> arch/arm/mach-omap2/id.c:262:20: error: 'OMAP3_HAS_IVA' undeclared (first use in this function)
      omap_features |= OMAP3_HAS_ ##feat;   \
                       ^
   arch/arm/mach-omap2/id.c:274:2: note: in expansion of macro 'OMAP3_CHECK_FEATURE'
     OMAP3_CHECK_FEATURE(status, IVA);
     ^
>> arch/arm/mach-omap2/id.c:262:20: error: 'OMAP3_HAS_SGX' undeclared (first use in this function)
      omap_features |= OMAP3_HAS_ ##feat;   \
                       ^
   arch/arm/mach-omap2/id.c:275:2: note: in expansion of macro 'OMAP3_CHECK_FEATURE'
     OMAP3_CHECK_FEATURE(status, SGX);
     ^
>> arch/arm/mach-omap2/id.c:262:20: error: 'OMAP3_HAS_NEON' undeclared (first use in this function)
      omap_features |= OMAP3_HAS_ ##feat;   \
                       ^
   arch/arm/mach-omap2/id.c:276:2: note: in expansion of macro 'OMAP3_CHECK_FEATURE'
     OMAP3_CHECK_FEATURE(status, NEON);
     ^
--
   In file included from arch/arm/mach-omap2/io.c:31:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
   In file included from arch/arm/mach-omap2/io.c:31:0:
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/io.c: In function '_omap2_init_reprogram_sdrc':
>> arch/arm/mach-omap2/io.c:389:2: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
     if (!cpu_is_omap34xx())
     ^
   arch/arm/mach-omap2/io.c: In function 'omap3_init_early':
>> arch/arm/mach-omap2/io.c:493:24: error: 'OMAP343X_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(OMAP343X_CLASS, OMAP2_L4_IO_ADDRESS(0x4830A000));
                           ^
   arch/arm/mach-omap2/io.c:493:24: note: each undeclared identifier is reported only once for each function it appears in
>> arch/arm/mach-omap2/io.c:505:2: error: implicit declaration of function 'omap3xxx_check_revision' [-Werror=implicit-function-declaration]
     omap3xxx_check_revision();
     ^
>> arch/arm/mach-omap2/io.c:506:2: error: implicit declaration of function 'omap3xxx_check_features' [-Werror=implicit-function-declaration]
     omap3xxx_check_features();
     ^
>> arch/arm/mach-omap2/io.c:522:3: error: implicit declaration of function 'cpu_is_omap3630' [-Werror=implicit-function-declaration]
      else if (cpu_is_omap3630())
      ^
>> arch/arm/mach-omap2/io.c:524:26: error: 'OMAP3430_REV_ES1_0' undeclared (first use in this function)
      else if (omap_rev() == OMAP3430_REV_ES1_0)
                             ^
   arch/arm/mach-omap2/io.c: In function 'ti814x_init_early':
>> arch/arm/mach-omap2/io.c:604:24: error: 'TI814X_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(TI814X_CLASS,
                           ^
>> arch/arm/mach-omap2/io.c:608:2: error: implicit declaration of function 'ti81xx_check_features' [-Werror=implicit-function-declaration]
     ti81xx_check_features();
     ^
   arch/arm/mach-omap2/io.c: In function 'ti816x_init_early':
>> arch/arm/mach-omap2/io.c:620:24: error: 'TI816X_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(TI816X_CLASS,
                           ^
   arch/arm/mach-omap2/io.c: In function 'am33xx_init_early':
>> arch/arm/mach-omap2/io.c:639:24: error: 'AM335X_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(AM335X_CLASS,
                           ^
>> arch/arm/mach-omap2/io.c:643:2: error: implicit declaration of function 'am33xx_check_features' [-Werror=implicit-function-declaration]
     am33xx_check_features();
     ^
   arch/arm/mach-omap2/io.c: In function 'am43xx_init_early':
   arch/arm/mach-omap2/io.c:661:24: error: 'AM335X_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(AM335X_CLASS,
                           ^
   arch/arm/mach-omap2/io.c: In function 'omap4430_init_early':
>> arch/arm/mach-omap2/io.c:685:24: error: 'OMAP443X_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(OMAP443X_CLASS,
                           ^
>> arch/arm/mach-omap2/io.c:689:2: error: implicit declaration of function 'omap4xxx_check_revision' [-Werror=implicit-function-declaration]
     omap4xxx_check_revision();
     ^
>> arch/arm/mach-omap2/io.c:690:2: error: implicit declaration of function 'omap4xxx_check_features' [-Werror=implicit-function-declaration]
     omap4xxx_check_features();
     ^
   arch/arm/mach-omap2/io.c: In function 'omap5_init_early':
>> arch/arm/mach-omap2/io.c:713:24: error: 'OMAP54XX_CLASS' undeclared (first use in this function)
     omap2_set_globals_tap(OMAP54XX_CLASS,
                           ^
>> arch/arm/mach-omap2/io.c:719:2: error: implicit declaration of function 'omap5xxx_check_revision' [-Werror=implicit-function-declaration]
     omap5xxx_check_revision();
     ^
   arch/arm/mach-omap2/io.c: In function 'dra7xx_init_early':
>> arch/arm/mach-omap2/io.c:744:2: error: implicit declaration of function 'dra7xxx_check_revision' [-Werror=implicit-function-declaration]
     dra7xxx_check_revision();
     ^
   arch/arm/mach-omap2/io.c: In function 'omap_sdrc_init':
>> arch/arm/mach-omap2/io.c:766:2: error: implicit declaration of function 'cpu_is_omap24xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap24xx() || omap3_has_sdrc()) {
     ^
--
   In file included from arch/arm/mach-omap2/control.c:21:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/control.c: In function 'omap_ctrl_write_dsp_boot_addr':
>> arch/arm/mach-omap2/control.c:245:2: error: implicit declaration of function 'cpu_is_omap243x' [-Werror=implicit-function-declaration]
     u32 offset = cpu_is_omap243x() ? OMAP243X_CONTROL_IVA2_BOOTADDR :
     ^
>> arch/arm/mach-omap2/control.c:246:8: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
           cpu_is_omap34xx() ? OMAP343X_CONTROL_IVA2_BOOTADDR :
           ^
>> arch/arm/mach-omap2/control.c:247:8: error: implicit declaration of function 'cpu_is_omap44xx' [-Werror=implicit-function-declaration]
           cpu_is_omap44xx() ? OMAP4_CTRL_MODULE_CORE_DSP_BOOTADDR :
           ^
   arch/arm/mach-omap2/control.c: In function 'omap3_save_scratchpad_contents':
>> arch/arm/mach-omap2/control.c:316:2: error: implicit declaration of function 'cpu_is_omap3630' [-Werror=implicit-function-declaration]
     if (cpu_is_omap3630())
     ^
>> arch/arm/mach-omap2/control.c:319:25: error: 'OMAP3430_REV_ES3_0' undeclared (first use in this function)
     else if (omap_rev() != OMAP3430_REV_ES3_0 &&
                            ^
   arch/arm/mach-omap2/control.c:319:25: note: each undeclared identifier is reported only once for each function it appears in
>> arch/arm/mach-omap2/control.c:320:20: error: 'OMAP3430_REV_ES3_1' undeclared (first use in this function)
         omap_rev() != OMAP3430_REV_ES3_1 &&
                       ^
>> arch/arm/mach-omap2/control.c:321:20: error: 'OMAP3430_REV_ES3_1_2' undeclared (first use in this function)
         omap_rev() != OMAP3430_REV_ES3_1_2)
                       ^
   cc1: some warnings being treated as errors
--
   In file included from arch/arm/mach-omap2/devices.c:31:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/devices.c: In function 'omap3_l3_init':
>> arch/arm/mach-omap2/devices.c:50:2: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
     if (!(cpu_is_omap34xx()) || of_have_populated_dt())
     ^
   arch/arm/mach-omap2/devices.c: At top level:
>> arch/arm/mach-omap2/devices.c:66:1: warning: data definition has no type or storage class
    omap_postcore_initcall(omap3_l3_init);
    ^
>> arch/arm/mach-omap2/devices.c:66:1: error: type defaults to 'int' in declaration of 'omap_postcore_initcall' [-Werror=implicit-int]
>> arch/arm/mach-omap2/devices.c:66:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/devices.c:214:1: warning: data definition has no type or storage class
    omap_arch_initcall(omap2_init_devices);
    ^
>> arch/arm/mach-omap2/devices.c:214:1: error: type defaults to 'int' in declaration of 'omap_arch_initcall' [-Werror=implicit-int]
   arch/arm/mach-omap2/devices.c:214:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/devices.c:240:1: warning: data definition has no type or storage class
    omap_postcore_initcall(omap_gpmc_init);
    ^
   arch/arm/mach-omap2/devices.c:240:1: error: type defaults to 'int' in declaration of 'omap_postcore_initcall' [-Werror=implicit-int]
   arch/arm/mach-omap2/devices.c:240:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/devices.c:40:19: warning: 'omap3_l3_init' defined but not used [-Wunused-function]
    static int __init omap3_l3_init(void)
                      ^
   arch/arm/mach-omap2/devices.c:193:19: warning: 'omap2_init_devices' defined but not used [-Wunused-function]
    static int __init omap2_init_devices(void)
                      ^
   arch/arm/mach-omap2/devices.c:216:19: warning: 'omap_gpmc_init' defined but not used [-Wunused-function]
    static int __init omap_gpmc_init(void)
                      ^
   cc1: some warnings being treated as errors
--
   In file included from arch/arm/mach-omap2/serial.c:36:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
>> arch/arm/mach-omap2/serial.c:216:1: warning: data definition has no type or storage class
    omap_postcore_initcall(omap_serial_early_init);
    ^
>> arch/arm/mach-omap2/serial.c:216:1: error: type defaults to 'int' in declaration of 'omap_postcore_initcall' [-Werror=implicit-int]
>> arch/arm/mach-omap2/serial.c:216:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/serial.c: In function 'omap_serial_init_port':
>> arch/arm/mach-omap2/serial.c:289:2: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
     if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
     ^
>> arch/arm/mach-omap2/serial.c:289:2: error: implicit declaration of function 'cpu_is_omap44xx' [-Werror=implicit-function-declaration]
   arch/arm/mach-omap2/serial.c: At top level:
   arch/arm/mach-omap2/serial.c:176:19: warning: 'omap_serial_early_init' defined but not used [-Wunused-function]
    static int __init omap_serial_early_init(void)
                      ^
   cc1: some warnings being treated as errors
--
   In file included from arch/arm/mach-omap2/timer.c:55:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/timer.c: In function 'omap_dmtimer_init':
>> arch/arm/mach-omap2/timer.c:206:2: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
     if (!cpu_is_omap34xx() && !soc_is_dra7xx())
     ^
   arch/arm/mach-omap2/timer.c: In function 'omap_dm_timer_get_errata':
>> arch/arm/mach-omap2/timer.c:223:2: error: implicit declaration of function 'cpu_is_omap24xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap24xx())
     ^
   arch/arm/mach-omap2/timer.c: At top level:
>> arch/arm/mach-omap2/timer.c:746:1: warning: data definition has no type or storage class
    omap_arch_initcall(omap2_dm_timer_init);
    ^
>> arch/arm/mach-omap2/timer.c:746:1: error: type defaults to 'int' in declaration of 'omap_arch_initcall' [-Werror=implicit-int]
>> arch/arm/mach-omap2/timer.c:746:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/timer.c:730:19: warning: 'omap2_dm_timer_init' defined but not used [-Wunused-function]
    static int __init omap2_dm_timer_init(void)
                      ^
   cc1: some warnings being treated as errors
--
   In file included from arch/arm/mach-omap2/pm.c:27:0:
>> arch/arm/mach-omap2/soc.h:194:0: error: unterminated #if
    #if defined(CONFIG_SOC_OMAP2420)
    ^
>> arch/arm/mach-omap2/soc.h:36:0: error: unterminated #ifndef
    #ifndef __ASSEMBLY__
    ^
   arch/arm/mach-omap2/pm.c: In function 'omap2_init_processor_devices':
>> arch/arm/mach-omap2/pm.c:99:2: error: implicit declaration of function 'omap3_has_iva' [-Werror=implicit-function-declaration]
     if (omap3_has_iva())
     ^
>> arch/arm/mach-omap2/pm.c:102:2: error: implicit declaration of function 'cpu_is_omap44xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap44xx()) {
     ^
   arch/arm/mach-omap2/pm.c: In function 'omap_pm_begin':
>> arch/arm/mach-omap2/pm.c:224:2: error: implicit declaration of function 'cpu_is_omap34xx' [-Werror=implicit-function-declaration]
     if (cpu_is_omap34xx())
     ^
   arch/arm/mach-omap2/pm.c: At top level:
>> arch/arm/mach-omap2/pm.c:297:1: warning: data definition has no type or storage class
    omap_postcore_initcall(omap2_common_pm_init);
    ^
>> arch/arm/mach-omap2/pm.c:297:1: error: type defaults to 'int' in declaration of 'omap_postcore_initcall' [-Werror=implicit-int]
>> arch/arm/mach-omap2/pm.c:297:1: warning: parameter names (without types) in function declaration
   arch/arm/mach-omap2/pm.c:289:19: warning: 'omap2_common_pm_init' defined but not used [-Wunused-function]
    static int __init omap2_common_pm_init(void)
                      ^
   cc1: some warnings being treated as errors
..

vim +194 arch/arm/mach-omap2/soc.h

c49f34bc Tony Lindgren  2012-08-31   30  #include "omap34xx.h"
c49f34bc Tony Lindgren  2012-08-31   31  #include "omap44xx.h"
c49f34bc Tony Lindgren  2012-08-31   32  #include "ti81xx.h"
c49f34bc Tony Lindgren  2012-08-31   33  #include "am33xx.h"
c49f34bc Tony Lindgren  2012-08-31   34  #include "omap54xx.h"
e4c060db Tony Lindgren  2012-10-05   35  
e4c060db Tony Lindgren  2012-10-05  @36  #ifndef __ASSEMBLY__
e4c060db Tony Lindgren  2012-10-05   37  
e4c060db Tony Lindgren  2012-10-05   38  #include <linux/bitops.h>
6852215a R Sricharan    2013-02-06   39  #include <linux/of.h>
e4c060db Tony Lindgren  2012-10-05   40  
e4c060db Tony Lindgren  2012-10-05   41  /*
e4c060db Tony Lindgren  2012-10-05   42   * Test if multicore OMAP support is needed
e4c060db Tony Lindgren  2012-10-05   43   */
e4c060db Tony Lindgren  2012-10-05   44  #undef MULTI_OMAP2
e4c060db Tony Lindgren  2012-10-05   45  #define MULTI_OMAP2
6852215a R Sricharan    2013-02-06   46  
e4c060db Tony Lindgren  2012-10-05   47  /*
e4c060db Tony Lindgren  2012-10-05   48   * Omap device type i.e. EMU/HS/TST/GP/BAD
e4c060db Tony Lindgren  2012-10-05   49   */
e4c060db Tony Lindgren  2012-10-05   50  #define OMAP2_DEVICE_TYPE_TEST		0
e4c060db Tony Lindgren  2012-10-05   51  #define OMAP2_DEVICE_TYPE_EMU		1
e4c060db Tony Lindgren  2012-10-05   52  #define OMAP2_DEVICE_TYPE_SEC		2
e4c060db Tony Lindgren  2012-10-05   53  #define OMAP2_DEVICE_TYPE_GP		3
e4c060db Tony Lindgren  2012-10-05   54  #define OMAP2_DEVICE_TYPE_BAD		4
e4c060db Tony Lindgren  2012-10-05   55  
e4c060db Tony Lindgren  2012-10-05   56  int omap_type(void);
e4c060db Tony Lindgren  2012-10-05   57  
e4c060db Tony Lindgren  2012-10-05   58  /*
e4c060db Tony Lindgren  2012-10-05   59   * omap_rev bits:
d0b50905 Tony Lindgren  2015-10-16   60   * SoC id bits	(0730, 1510, 1710, 2422...)	[31:16]
d0b50905 Tony Lindgren  2015-10-16   61   * SoC revision	(See _REV_ defined in cpu.h)	[15:08]
d0b50905 Tony Lindgren  2015-10-16   62   * SoC class bits (15xx, 16xx, 24xx, 34xx...)	[07:00]
e4c060db Tony Lindgren  2012-10-05   63   */
e4c060db Tony Lindgren  2012-10-05   64  unsigned int omap_rev(void);
e4c060db Tony Lindgren  2012-10-05   65  
816a65ef Tony Lindgren  2013-01-11   66  static inline int soc_is_omap(void)
816a65ef Tony Lindgren  2013-01-11   67  {
816a65ef Tony Lindgren  2013-01-11   68  	return omap_rev() != 0;
816a65ef Tony Lindgren  2013-01-11   69  }
816a65ef Tony Lindgren  2013-01-11   70  
e4c060db Tony Lindgren  2012-10-05   71  /*
d0b50905 Tony Lindgren  2015-10-16   72   * Get the SoC revision for OMAP devices
e4c060db Tony Lindgren  2012-10-05   73   */
e4c060db Tony Lindgren  2012-10-05   74  #define GET_OMAP_REVISION()	((omap_rev() >> 8) & 0xff)
e4c060db Tony Lindgren  2012-10-05   75  
e4c060db Tony Lindgren  2012-10-05   76  /*
e4c060db Tony Lindgren  2012-10-05   77   * Macros to group OMAP into cpu classes.
e4c060db Tony Lindgren  2012-10-05   78   * These can be used in most places.
d0b50905 Tony Lindgren  2015-10-16   79   * soc_is_omap24xx():	True for OMAP2420, OMAP2422, OMAP2423, OMAP2430
d0b50905 Tony Lindgren  2015-10-16   80   * soc_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
d0b50905 Tony Lindgren  2015-10-16   81   * soc_is_omap243x():	True for OMAP2430
d0b50905 Tony Lindgren  2015-10-16   82   * soc_is_omap343x():	True for OMAP3430
d0b50905 Tony Lindgren  2015-10-16   83   * soc_is_omap443x():	True for OMAP4430
d0b50905 Tony Lindgren  2015-10-16   84   * soc_is_omap446x():	True for OMAP4460
d0b50905 Tony Lindgren  2015-10-16   85   * soc_is_omap447x():	True for OMAP4470
e4c060db Tony Lindgren  2012-10-05   86   * soc_is_omap543x():	True for OMAP5430, OMAP5432
e4c060db Tony Lindgren  2012-10-05   87   */
e4c060db Tony Lindgren  2012-10-05   88  #define GET_OMAP_CLASS	(omap_rev() & 0xff)
e4c060db Tony Lindgren  2012-10-05   89  
e4c060db Tony Lindgren  2012-10-05   90  #define IS_OMAP_CLASS(class, id)			\
e4c060db Tony Lindgren  2012-10-05   91  static inline int is_omap ##class (void)		\
e4c060db Tony Lindgren  2012-10-05   92  {							\
e4c060db Tony Lindgren  2012-10-05   93  	return (GET_OMAP_CLASS == (id)) ? 1 : 0;	\
e4c060db Tony Lindgren  2012-10-05   94  }
e4c060db Tony Lindgren  2012-10-05   95  
e4c060db Tony Lindgren  2012-10-05   96  #define GET_AM_CLASS	((omap_rev() >> 24) & 0xff)
e4c060db Tony Lindgren  2012-10-05   97  
e4c060db Tony Lindgren  2012-10-05   98  #define IS_AM_CLASS(class, id)				\
e4c060db Tony Lindgren  2012-10-05   99  static inline int is_am ##class (void)			\
e4c060db Tony Lindgren  2012-10-05  100  {							\
e4c060db Tony Lindgren  2012-10-05  101  	return (GET_AM_CLASS == (id)) ? 1 : 0;		\
e4c060db Tony Lindgren  2012-10-05  102  }
e4c060db Tony Lindgren  2012-10-05  103  
e4c060db Tony Lindgren  2012-10-05  104  #define GET_TI_CLASS	((omap_rev() >> 24) & 0xff)
e4c060db Tony Lindgren  2012-10-05  105  
e4c060db Tony Lindgren  2012-10-05  106  #define IS_TI_CLASS(class, id)			\
e4c060db Tony Lindgren  2012-10-05  107  static inline int is_ti ##class (void)		\
e4c060db Tony Lindgren  2012-10-05  108  {							\
e4c060db Tony Lindgren  2012-10-05  109  	return (GET_TI_CLASS == (id)) ? 1 : 0;	\
e4c060db Tony Lindgren  2012-10-05  110  }
e4c060db Tony Lindgren  2012-10-05  111  
06c2d368 Keerthy        2016-02-17  112  #define GET_DRA_CLASS	((omap_rev() >> 24) & 0xff)
06c2d368 Keerthy        2016-02-17  113  
06c2d368 Keerthy        2016-02-17  114  #define IS_DRA_CLASS(class, id)				\
06c2d368 Keerthy        2016-02-17  115  static inline int is_dra ##class (void)			\
06c2d368 Keerthy        2016-02-17  116  {							\
06c2d368 Keerthy        2016-02-17  117  	return (GET_DRA_CLASS == (id)) ? 1 : 0;		\
06c2d368 Keerthy        2016-02-17  118  }
06c2d368 Keerthy        2016-02-17  119  
e4c060db Tony Lindgren  2012-10-05  120  #define GET_OMAP_SUBCLASS	((omap_rev() >> 20) & 0x0fff)
e4c060db Tony Lindgren  2012-10-05  121  
e4c060db Tony Lindgren  2012-10-05  122  #define IS_OMAP_SUBCLASS(subclass, id)			\
e4c060db Tony Lindgren  2012-10-05  123  static inline int is_omap ##subclass (void)		\
e4c060db Tony Lindgren  2012-10-05  124  {							\
e4c060db Tony Lindgren  2012-10-05  125  	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
e4c060db Tony Lindgren  2012-10-05  126  }
e4c060db Tony Lindgren  2012-10-05  127  
e4c060db Tony Lindgren  2012-10-05  128  #define IS_TI_SUBCLASS(subclass, id)			\
e4c060db Tony Lindgren  2012-10-05  129  static inline int is_ti ##subclass (void)		\
e4c060db Tony Lindgren  2012-10-05  130  {							\
e4c060db Tony Lindgren  2012-10-05  131  	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
e4c060db Tony Lindgren  2012-10-05  132  }
e4c060db Tony Lindgren  2012-10-05  133  
e4c060db Tony Lindgren  2012-10-05  134  #define IS_AM_SUBCLASS(subclass, id)			\
e4c060db Tony Lindgren  2012-10-05  135  static inline int is_am ##subclass (void)		\
e4c060db Tony Lindgren  2012-10-05  136  {							\
e4c060db Tony Lindgren  2012-10-05  137  	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
e4c060db Tony Lindgren  2012-10-05  138  }
e4c060db Tony Lindgren  2012-10-05  139  
06c2d368 Keerthy        2016-02-17  140  #define IS_DRA_SUBCLASS(subclass, id)			\
06c2d368 Keerthy        2016-02-17  141  static inline int is_dra ##subclass (void)		\
06c2d368 Keerthy        2016-02-17  142  {							\
06c2d368 Keerthy        2016-02-17  143  	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
06c2d368 Keerthy        2016-02-17  144  }
06c2d368 Keerthy        2016-02-17  145  
e4c060db Tony Lindgren  2012-10-05  146  IS_OMAP_CLASS(24xx, 0x24)
e4c060db Tony Lindgren  2012-10-05  147  IS_OMAP_CLASS(34xx, 0x34)
e4c060db Tony Lindgren  2012-10-05  148  IS_OMAP_CLASS(44xx, 0x44)
e4c060db Tony Lindgren  2012-10-05  149  IS_AM_CLASS(35xx, 0x35)
e4c060db Tony Lindgren  2012-10-05  150  IS_OMAP_CLASS(54xx, 0x54)
e4c060db Tony Lindgren  2012-10-05  151  IS_AM_CLASS(33xx, 0x33)
c664d0a9 Afzal Mohammed 2013-05-27  152  IS_AM_CLASS(43xx, 0x43)
e4c060db Tony Lindgren  2012-10-05  153  
e4c060db Tony Lindgren  2012-10-05  154  IS_TI_CLASS(81xx, 0x81)
06c2d368 Keerthy        2016-02-17  155  IS_DRA_CLASS(7xx, 0x7)
e4c060db Tony Lindgren  2012-10-05  156  
e4c060db Tony Lindgren  2012-10-05  157  IS_OMAP_SUBCLASS(242x, 0x242)
e4c060db Tony Lindgren  2012-10-05  158  IS_OMAP_SUBCLASS(243x, 0x243)
e4c060db Tony Lindgren  2012-10-05  159  IS_OMAP_SUBCLASS(343x, 0x343)
e4c060db Tony Lindgren  2012-10-05  160  IS_OMAP_SUBCLASS(363x, 0x363)
e4c060db Tony Lindgren  2012-10-05  161  IS_OMAP_SUBCLASS(443x, 0x443)
e4c060db Tony Lindgren  2012-10-05  162  IS_OMAP_SUBCLASS(446x, 0x446)
e4c060db Tony Lindgren  2012-10-05  163  IS_OMAP_SUBCLASS(447x, 0x447)
e4c060db Tony Lindgren  2012-10-05  164  IS_OMAP_SUBCLASS(543x, 0x543)
e4c060db Tony Lindgren  2012-10-05  165  
e4c060db Tony Lindgren  2012-10-05  166  IS_TI_SUBCLASS(816x, 0x816)
e4c060db Tony Lindgren  2012-10-05  167  IS_TI_SUBCLASS(814x, 0x814)
e4c060db Tony Lindgren  2012-10-05  168  IS_AM_SUBCLASS(335x, 0x335)
c664d0a9 Afzal Mohammed 2013-05-27  169  IS_AM_SUBCLASS(437x, 0x437)
06c2d368 Keerthy        2016-02-17  170  IS_DRA_SUBCLASS(75x, 0x75)
06c2d368 Keerthy        2016-02-17  171  IS_DRA_SUBCLASS(72x, 0x72)
e4c060db Tony Lindgren  2012-10-05  172  
d0b50905 Tony Lindgren  2015-10-16  173  #define soc_is_ti81xx()			0
d0b50905 Tony Lindgren  2015-10-16  174  #define soc_is_ti816x()			0
d0b50905 Tony Lindgren  2015-10-16  175  #define soc_is_ti814x()			0
e4c060db Tony Lindgren  2012-10-05  176  #define soc_is_am35xx()			0
e4c060db Tony Lindgren  2012-10-05  177  #define soc_is_am33xx()			0
e4c060db Tony Lindgren  2012-10-05  178  #define soc_is_am335x()			0
c664d0a9 Afzal Mohammed 2013-05-27  179  #define soc_is_am43xx()			0
c664d0a9 Afzal Mohammed 2013-05-27  180  #define soc_is_am437x()			0
d0b50905 Tony Lindgren  2015-10-16  181  #define soc_is_omap44xx()		0
d0b50905 Tony Lindgren  2015-10-16  182  #define soc_is_omap443x()		0
d0b50905 Tony Lindgren  2015-10-16  183  #define soc_is_omap446x()		0
d0b50905 Tony Lindgren  2015-10-16  184  #define soc_is_omap447x()		0
e4c060db Tony Lindgren  2012-10-05  185  #define soc_is_omap54xx()		0
e4c060db Tony Lindgren  2012-10-05  186  #define soc_is_omap543x()		0
6852215a R Sricharan    2013-02-06  187  #define soc_is_dra7xx()			0
af438fec Rajendra Nayak 2014-08-27  188  #define soc_is_dra74x()			0
af438fec Rajendra Nayak 2014-08-27  189  #define soc_is_dra72x()			0
e4c060db Tony Lindgren  2012-10-05  190  
e4c060db Tony Lindgren  2012-10-05  191  #if defined(CONFIG_ARCH_OMAP2)
d0b50905 Tony Lindgren  2015-10-16  192  #  define soc_is_omap24xx()		is_omap24xx()
e4c060db Tony Lindgren  2012-10-05  193  #endif
e4c060db Tony Lindgren  2012-10-05 @194  #if defined(CONFIG_SOC_OMAP2420)
d0b50905 Tony Lindgren  2015-10-16  195  #  define soc_is_omap242x()		is_omap242x()
e4c060db Tony Lindgren  2012-10-05  196  #if defined(CONFIG_SOC_OMAP2430)
d0b50905 Tony Lindgren  2015-10-16  197  #  define soc_is_omap243x()		is_omap243x()

:::::: The code at line 194 was first introduced by commit
:::::: e4c060db2c13f10de09101afc564763f9fd0019a ARM: OMAP: Split plat/cpu.h into local soc.h for mach-omap1 and mach-omap2

:::::: TO: Tony Lindgren <tony@atomide.com>
:::::: CC: Tony Lindgren <tony@atomide.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36970 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160406/e86f7d89/attachment-0001.obj>
