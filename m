From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Oct 2015 03:56:11 +0800
Subject: [PATCH v2 1/2] phy: keystone: serdes driver for gbe 10gbe and pcie
In-Reply-To: <1445281040-14742-2-git-send-email-w-kwok2@ti.com>
Message-ID: <201510200310.ag8Bondy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi WingMan,

[auto build test ERROR on pci/next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/WingMan-Kwok/Common-SerDes-driver-for-TI-s-Keystone-Platforms/20151020-030259
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/phy/phy-keystone-serdes.c: In function 'kserdes_xfw_mem_init':
>> drivers/phy/phy-keystone-serdes.c:197:31: error: 'SZ_64K' undeclared (first use in this function)
    #define KSERDES_XFW_MEM_SIZE  SZ_64K
                                  ^
>> drivers/phy/phy-keystone-serdes.c:203:3: note: in expansion of macro 'KSERDES_XFW_MEM_SIZE'
     (KSERDES_XFW_MEM_SIZE - KSERDES_XFW_CONFIG_MEM_SIZE)
      ^
>> drivers/phy/phy-keystone-serdes.c:1979:40: note: in expansion of macro 'KSERDES_XFW_CONFIG_START_ADDR'
     kserdes_writel(sc->regs, MEM_ADR_REG, KSERDES_XFW_CONFIG_START_ADDR);
                                           ^
   drivers/phy/phy-keystone-serdes.c:197:31: note: each undeclared identifier is reported only once for each function it appears in
    #define KSERDES_XFW_MEM_SIZE  SZ_64K
                                  ^
>> drivers/phy/phy-keystone-serdes.c:203:3: note: in expansion of macro 'KSERDES_XFW_MEM_SIZE'
     (KSERDES_XFW_MEM_SIZE - KSERDES_XFW_CONFIG_MEM_SIZE)
      ^
>> drivers/phy/phy-keystone-serdes.c:1979:40: note: in expansion of macro 'KSERDES_XFW_CONFIG_START_ADDR'
     kserdes_writel(sc->regs, MEM_ADR_REG, KSERDES_XFW_CONFIG_START_ADDR);
                                           ^
>> drivers/phy/phy-keystone-serdes.c:198:37: error: 'SZ_64' undeclared (first use in this function)
    #define KSERDES_XFW_CONFIG_MEM_SIZE SZ_64
                                        ^
>> drivers/phy/phy-keystone-serdes.c:203:26: note: in expansion of macro 'KSERDES_XFW_CONFIG_MEM_SIZE'
     (KSERDES_XFW_MEM_SIZE - KSERDES_XFW_CONFIG_MEM_SIZE)
                             ^
>> drivers/phy/phy-keystone-serdes.c:1979:40: note: in expansion of macro 'KSERDES_XFW_CONFIG_START_ADDR'
     kserdes_writel(sc->regs, MEM_ADR_REG, KSERDES_XFW_CONFIG_START_ADDR);
                                           ^

vim +/SZ_64K +197 drivers/phy/phy-keystone-serdes.c

   191	
   192	#define ANEG_1G_10G_OPT_MASK		GENMASK(7, 5)
   193	
   194	#define SERDES_REG_INDEX		0
   195	
   196	/* SERDES internal memory */
 > 197	#define KSERDES_XFW_MEM_SIZE		SZ_64K
 > 198	#define KSERDES_XFW_CONFIG_MEM_SIZE	SZ_64
   199	#define KSERDES_XFW_NUM_PARAMS		5
   200	
   201	/* Last 64B of the 64KB internal mem is for parameters */
   202	#define KSERDES_XFW_CONFIG_START_ADDR \
 > 203		(KSERDES_XFW_MEM_SIZE - KSERDES_XFW_CONFIG_MEM_SIZE)
   204	
   205	#define KSERDES_XFW_PARAM_START_ADDR \
   206		(KSERDES_XFW_MEM_SIZE - (KSERDES_XFW_NUM_PARAMS * 4))

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51512 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151020/0630fd9e/attachment-0001.obj>
