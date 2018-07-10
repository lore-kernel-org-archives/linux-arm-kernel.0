From: lkp@intel.com (kbuild test robot)
Date: Tue, 10 Jul 2018 21:24:16 +0800
Subject: [stericsson:ux500-mcde 3/3] include/linux/mfd/dbx500-prcmu.h:422:19:
 error: redefinition of 'prcmu_abb_read'
Message-ID: <201807102111.C6tMcKqG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-mcde
head:   ee7f210157e9d5a082751c1c1a556864d3e47892
commit: ee7f210157e9d5a082751c1c1a556864d3e47892 [3/3] MCDE hack
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ee7f210157e9d5a082751c1c1a556864d3e47892
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/gpu//drm/mcde/mcde_drv.c:46:
>> include/linux/mfd/dbx500-prcmu.h:422:19: error: redefinition of 'prcmu_abb_read'
    static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
                      ^~~~~~~~~~~~~~
   In file included from include/linux/mfd/dbx500-prcmu.h:211,
                    from drivers/gpu//drm/mcde/mcde_drv.c:46:
   include/linux/mfd/db8500-prcmu.h:641:19: note: previous definition of 'prcmu_abb_read' was here
    static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
                      ^~~~~~~~~~~~~~
   In file included from drivers/gpu//drm/mcde/mcde_drv.c:46:
>> include/linux/mfd/dbx500-prcmu.h:427:19: error: redefinition of 'prcmu_abb_write'
    static inline int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size)
                      ^~~~~~~~~~~~~~~
   In file included from include/linux/mfd/dbx500-prcmu.h:211,
                    from drivers/gpu//drm/mcde/mcde_drv.c:46:
   include/linux/mfd/db8500-prcmu.h:646:19: note: previous definition of 'prcmu_abb_write' was here
    static inline int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size)
                      ^~~~~~~~~~~~~~~
   In file included from drivers/gpu//drm/mcde/mcde_drv.c:46:
>> include/linux/mfd/dbx500-prcmu.h:438:19: error: redefinition of 'prcmu_config_clkout'
    static inline int prcmu_config_clkout(u8 clkout, u8 source, u8 div)
                      ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mfd/dbx500-prcmu.h:211,
                    from drivers/gpu//drm/mcde/mcde_drv.c:46:
   include/linux/mfd/db8500-prcmu.h:611:19: note: previous definition of 'prcmu_config_clkout' was here
    static inline int prcmu_config_clkout(u8 clkout, u8 source, u8 div)
                      ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu//drm/mcde/mcde_drv.c:46:
>> include/linux/mfd/dbx500-prcmu.h:500:19: error: redefinition of 'prcmu_ac_wake_req'
    static inline int prcmu_ac_wake_req(void)
                      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/mfd/dbx500-prcmu.h:211,
                    from drivers/gpu//drm/mcde/mcde_drv.c:46:
   include/linux/mfd/db8500-prcmu.h:651:19: note: previous definition of 'prcmu_ac_wake_req' was here
    static inline int prcmu_ac_wake_req(void)
                      ^~~~~~~~~~~~~~~~~
   In file included from drivers/gpu//drm/mcde/mcde_drv.c:46:
>> include/linux/mfd/dbx500-prcmu.h:505:20: error: redefinition of 'prcmu_ac_sleep_req'
    static inline void prcmu_ac_sleep_req(void) {}
                       ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/mfd/dbx500-prcmu.h:211,
                    from drivers/gpu//drm/mcde/mcde_drv.c:46:
   include/linux/mfd/db8500-prcmu.h:656:20: note: previous definition of 'prcmu_ac_sleep_req' was here
    static inline void prcmu_ac_sleep_req(void) {}
                       ^~~~~~~~~~~~~~~~~~
   drivers/gpu//drm/mcde/mcde_drv.c: In function 'mcde_irq':
   drivers/gpu//drm/mcde/mcde_drv.c:133:6: warning: unused variable 'val' [-Wunused-variable]
     u32 val;
         ^~~
   drivers/gpu//drm/mcde/mcde_drv.c:132:15: warning: unused variable 'mcde' [-Wunused-variable]
     struct mcde *mcde = data;
                  ^~~~
   drivers/gpu//drm/mcde/mcde_drv.c: In function 'mcde_modeset_init':
   drivers/gpu//drm/mcde/mcde_drv.c:143:15: warning: unused variable 'mcde' [-Wunused-variable]
     struct mcde *mcde = drm->dev_private;
                  ^~~~
   drivers/gpu//drm/mcde/mcde_drv.c: In function 'mcde_drm_bind':
   drivers/gpu//drm/mcde/mcde_drv.c:203:19: warning: unused variable 'res' [-Wunused-variable]
     struct resource *res;
                      ^~~
   drivers/gpu//drm/mcde/mcde_drv.c: In function 'mcde_probe':
>> drivers/gpu//drm/mcde/mcde_drv.c:314:50: warning: passing argument 2 of 'prcmu_qos_update_requirement' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     prcmu_qos_update_requirement(PRCMU_QOS_APE_OPP, dev_name(dev),
                                                     ^~~~~~~~~~~~~
   In file included from drivers/gpu//drm/mcde/mcde_drv.c:46:
   include/linux/mfd/dbx500-prcmu.h:625:19: note: expected 'char *' but argument is of type 'const char *'
                char *name, s32 new_value)
                ~~~~~~^~~~
   drivers/gpu//drm/mcde/mcde_drv.c:317:50: warning: passing argument 2 of 'prcmu_qos_update_requirement' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     prcmu_qos_update_requirement(PRCMU_QOS_APE_OPP, dev_name(dev),
                                                     ^~~~~~~~~~~~~
   In file included from drivers/gpu//drm/mcde/mcde_drv.c:46:
   include/linux/mfd/dbx500-prcmu.h:625:19: note: expected 'char *' but argument is of type 'const char *'
                char *name, s32 new_value)
                ~~~~~~^~~~
--
   drivers/gpu//drm/panel/panel-samsung-s6d16d0.c: In function 's6d16d0_get_modes':
   drivers/gpu//drm/panel/panel-samsung-s6d16d0.c:108:18: warning: unused variable 's6' [-Wunused-variable]
     struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
                     ^~
   drivers/gpu//drm/panel/panel-samsung-s6d16d0.c: In function 's6d16d0_unprepare':
>> drivers/gpu//drm/panel/panel-samsung-s6d16d0.c:59:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
--
   In file included from drivers/gpu/drm/mcde/mcde_drv.c:46:
>> include/linux/mfd/dbx500-prcmu.h:422:19: error: redefinition of 'prcmu_abb_read'
    static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
                      ^~~~~~~~~~~~~~
   In file included from include/linux/mfd/dbx500-prcmu.h:211,
                    from drivers/gpu/drm/mcde/mcde_drv.c:46:
   include/linux/mfd/db8500-prcmu.h:641:19: note: previous definition of 'prcmu_abb_read' was here
    static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
                      ^~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/mcde/mcde_drv.c:46:
>> include/linux/mfd/dbx500-prcmu.h:427:19: error: redefinition of 'prcmu_abb_write'
    static inline int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size)
                      ^~~~~~~~~~~~~~~
   In file included from include/linux/mfd/dbx500-prcmu.h:211,
                    from drivers/gpu/drm/mcde/mcde_drv.c:46:
   include/linux/mfd/db8500-prcmu.h:646:19: note: previous definition of 'prcmu_abb_write' was here
    static inline int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size)
                      ^~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/mcde/mcde_drv.c:46:
>> include/linux/mfd/dbx500-prcmu.h:438:19: error: redefinition of 'prcmu_config_clkout'
    static inline int prcmu_config_clkout(u8 clkout, u8 source, u8 div)
                      ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/mfd/dbx500-prcmu.h:211,
                    from drivers/gpu/drm/mcde/mcde_drv.c:46:
   include/linux/mfd/db8500-prcmu.h:611:19: note: previous definition of 'prcmu_config_clkout' was here
    static inline int prcmu_config_clkout(u8 clkout, u8 source, u8 div)
                      ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/mcde/mcde_drv.c:46:
>> include/linux/mfd/dbx500-prcmu.h:500:19: error: redefinition of 'prcmu_ac_wake_req'
    static inline int prcmu_ac_wake_req(void)
                      ^~~~~~~~~~~~~~~~~
   In file included from include/linux/mfd/dbx500-prcmu.h:211,
                    from drivers/gpu/drm/mcde/mcde_drv.c:46:
   include/linux/mfd/db8500-prcmu.h:651:19: note: previous definition of 'prcmu_ac_wake_req' was here
    static inline int prcmu_ac_wake_req(void)
                      ^~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/mcde/mcde_drv.c:46:
>> include/linux/mfd/dbx500-prcmu.h:505:20: error: redefinition of 'prcmu_ac_sleep_req'
    static inline void prcmu_ac_sleep_req(void) {}
                       ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/mfd/dbx500-prcmu.h:211,
                    from drivers/gpu/drm/mcde/mcde_drv.c:46:
   include/linux/mfd/db8500-prcmu.h:656:20: note: previous definition of 'prcmu_ac_sleep_req' was here
    static inline void prcmu_ac_sleep_req(void) {}
                       ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/mcde/mcde_drv.c: In function 'mcde_irq':
   drivers/gpu/drm/mcde/mcde_drv.c:133:6: warning: unused variable 'val' [-Wunused-variable]
     u32 val;
         ^~~
   drivers/gpu/drm/mcde/mcde_drv.c:132:15: warning: unused variable 'mcde' [-Wunused-variable]
     struct mcde *mcde = data;
                  ^~~~
   drivers/gpu/drm/mcde/mcde_drv.c: In function 'mcde_modeset_init':
   drivers/gpu/drm/mcde/mcde_drv.c:143:15: warning: unused variable 'mcde' [-Wunused-variable]
     struct mcde *mcde = drm->dev_private;
                  ^~~~
   drivers/gpu/drm/mcde/mcde_drv.c: In function 'mcde_drm_bind':
   drivers/gpu/drm/mcde/mcde_drv.c:203:19: warning: unused variable 'res' [-Wunused-variable]
     struct resource *res;
                      ^~~
   drivers/gpu/drm/mcde/mcde_drv.c: In function 'mcde_probe':
   drivers/gpu/drm/mcde/mcde_drv.c:314:50: warning: passing argument 2 of 'prcmu_qos_update_requirement' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     prcmu_qos_update_requirement(PRCMU_QOS_APE_OPP, dev_name(dev),
                                                     ^~~~~~~~~~~~~
   In file included from drivers/gpu/drm/mcde/mcde_drv.c:46:
   include/linux/mfd/dbx500-prcmu.h:625:19: note: expected 'char *' but argument is of type 'const char *'
                char *name, s32 new_value)
                ~~~~~~^~~~
   drivers/gpu/drm/mcde/mcde_drv.c:317:50: warning: passing argument 2 of 'prcmu_qos_update_requirement' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     prcmu_qos_update_requirement(PRCMU_QOS_APE_OPP, dev_name(dev),
                                                     ^~~~~~~~~~~~~
   In file included from drivers/gpu/drm/mcde/mcde_drv.c:46:
   include/linux/mfd/dbx500-prcmu.h:625:19: note: expected 'char *' but argument is of type 'const char *'
                char *name, s32 new_value)
                ~~~~~~^~~~

vim +/prcmu_abb_read +422 include/linux/mfd/dbx500-prcmu.h

fea799e3 Mattias Nilsson 2011-08-12  421  
fea799e3 Mattias Nilsson 2011-08-12 @422  static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)
fea799e3 Mattias Nilsson 2011-08-12  423  {
fea799e3 Mattias Nilsson 2011-08-12  424  	return -ENOSYS;
fea799e3 Mattias Nilsson 2011-08-12  425  }
fea799e3 Mattias Nilsson 2011-08-12  426  
fea799e3 Mattias Nilsson 2011-08-12 @427  static inline int prcmu_abb_write(u8 slave, u8 reg, u8 *value, u8 size)
fea799e3 Mattias Nilsson 2011-08-12  428  {
fea799e3 Mattias Nilsson 2011-08-12  429  	return -ENOSYS;
fea799e3 Mattias Nilsson 2011-08-12  430  }
fea799e3 Mattias Nilsson 2011-08-12  431  
3c3e4898 Mattias Nilsson 2012-03-08  432  static inline int prcmu_abb_write_masked(u8 slave, u8 reg, u8 *value, u8 *mask,
3c3e4898 Mattias Nilsson 2012-03-08  433  	u8 size)
3c3e4898 Mattias Nilsson 2012-03-08  434  {
3c3e4898 Mattias Nilsson 2012-03-08  435  	return -ENOSYS;
3c3e4898 Mattias Nilsson 2012-03-08  436  }
3c3e4898 Mattias Nilsson 2012-03-08  437  
fea799e3 Mattias Nilsson 2011-08-12 @438  static inline int prcmu_config_clkout(u8 clkout, u8 source, u8 div)
fea799e3 Mattias Nilsson 2011-08-12  439  {
fea799e3 Mattias Nilsson 2011-08-12  440  	return 0;
fea799e3 Mattias Nilsson 2011-08-12  441  }
fea799e3 Mattias Nilsson 2011-08-12  442  
fea799e3 Mattias Nilsson 2011-08-12  443  static inline int prcmu_request_clock(u8 clock, bool enable)
fea799e3 Mattias Nilsson 2011-08-12  444  {
fea799e3 Mattias Nilsson 2011-08-12  445  	return 0;
6b6fae2b Mattias Nilsson 2012-01-13  446  }
6b6fae2b Mattias Nilsson 2012-01-13  447  
6b6fae2b Mattias Nilsson 2012-01-13  448  static inline long prcmu_round_clock_rate(u8 clock, unsigned long rate)
6b6fae2b Mattias Nilsson 2012-01-13  449  {
6b6fae2b Mattias Nilsson 2012-01-13  450  	return 0;
6b6fae2b Mattias Nilsson 2012-01-13  451  }
6b6fae2b Mattias Nilsson 2012-01-13  452  
6b6fae2b Mattias Nilsson 2012-01-13  453  static inline int prcmu_set_clock_rate(u8 clock, unsigned long rate)
6b6fae2b Mattias Nilsson 2012-01-13  454  {
6b6fae2b Mattias Nilsson 2012-01-13  455  	return 0;
6b6fae2b Mattias Nilsson 2012-01-13  456  }
6b6fae2b Mattias Nilsson 2012-01-13  457  
6b6fae2b Mattias Nilsson 2012-01-13  458  static inline unsigned long prcmu_clock_rate(u8 clock)
6b6fae2b Mattias Nilsson 2012-01-13  459  {
6b6fae2b Mattias Nilsson 2012-01-13  460  	return 0;
fea799e3 Mattias Nilsson 2011-08-12  461  }
fea799e3 Mattias Nilsson 2011-08-12  462  
fea799e3 Mattias Nilsson 2011-08-12  463  static inline int prcmu_set_ape_opp(u8 opp)
fea799e3 Mattias Nilsson 2011-08-12  464  {
fea799e3 Mattias Nilsson 2011-08-12  465  	return 0;
fea799e3 Mattias Nilsson 2011-08-12  466  }
fea799e3 Mattias Nilsson 2011-08-12  467  
fea799e3 Mattias Nilsson 2011-08-12  468  static inline int prcmu_get_ape_opp(void)
fea799e3 Mattias Nilsson 2011-08-12  469  {
fea799e3 Mattias Nilsson 2011-08-12  470  	return APE_100_OPP;
fea799e3 Mattias Nilsson 2011-08-12  471  }
fea799e3 Mattias Nilsson 2011-08-12  472  
686f871b Ulf Hansson     2012-09-24  473  static inline int prcmu_request_ape_opp_100_voltage(bool enable)
686f871b Ulf Hansson     2012-09-24  474  {
686f871b Ulf Hansson     2012-09-24  475  	return 0;
686f871b Ulf Hansson     2012-09-24  476  }
686f871b Ulf Hansson     2012-09-24  477  
fea799e3 Mattias Nilsson 2011-08-12  478  static inline int prcmu_set_arm_opp(u8 opp)
fea799e3 Mattias Nilsson 2011-08-12  479  {
fea799e3 Mattias Nilsson 2011-08-12  480  	return 0;
fea799e3 Mattias Nilsson 2011-08-12  481  }
fea799e3 Mattias Nilsson 2011-08-12  482  
fea799e3 Mattias Nilsson 2011-08-12  483  static inline int prcmu_get_arm_opp(void)
fea799e3 Mattias Nilsson 2011-08-12  484  {
fea799e3 Mattias Nilsson 2011-08-12  485  	return ARM_100_OPP;
fea799e3 Mattias Nilsson 2011-08-12  486  }
fea799e3 Mattias Nilsson 2011-08-12  487  
fea799e3 Mattias Nilsson 2011-08-12  488  static inline int prcmu_get_ddr_opp(void)
fea799e3 Mattias Nilsson 2011-08-12  489  {
fea799e3 Mattias Nilsson 2011-08-12  490  	return DDR_100_OPP;
fea799e3 Mattias Nilsson 2011-08-12  491  }
fea799e3 Mattias Nilsson 2011-08-12  492  
fea799e3 Mattias Nilsson 2011-08-12  493  static inline void prcmu_system_reset(u16 reset_code) {}
fea799e3 Mattias Nilsson 2011-08-12  494  
fea799e3 Mattias Nilsson 2011-08-12  495  static inline u16 prcmu_get_reset_code(void)
fea799e3 Mattias Nilsson 2011-08-12  496  {
fea799e3 Mattias Nilsson 2011-08-12  497  	return 0;
fea799e3 Mattias Nilsson 2011-08-12  498  }
fea799e3 Mattias Nilsson 2011-08-12  499  
5261e101 Arun Murthy     2012-05-21 @500  static inline int prcmu_ac_wake_req(void)
5261e101 Arun Murthy     2012-05-21  501  {
5261e101 Arun Murthy     2012-05-21  502  	return 0;
5261e101 Arun Murthy     2012-05-21  503  }
fea799e3 Mattias Nilsson 2011-08-12  504  
fea799e3 Mattias Nilsson 2011-08-12 @505  static inline void prcmu_ac_sleep_req(void) {}
fea799e3 Mattias Nilsson 2011-08-12  506  

:::::: The code at line 422 was first introduced by commit
:::::: fea799e3d3ab84ac675de7e48a13a79fb76b6e63 mfd: Create a common interface for dbx500 PRCMU drivers

:::::: TO: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
:::::: CC: Samuel Ortiz <sameo@linux.intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54174 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/bf42a3ae/attachment-0001.gz>
