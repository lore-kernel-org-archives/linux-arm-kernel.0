From: lkp@intel.com (kbuild test robot)
Date: Sat, 20 Jan 2018 06:06:13 +0800
Subject: [PATCH net-next] net: stmmac: Fix reception of Broadcom switches
 tags
In-Reply-To: <20180116232545.22054-1-f.fainelli@gmail.com>
References: <20180116232545.22054-1-f.fainelli@gmail.com>
Message-ID: <201801200543.cKHnq3PE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

I love your patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Florian-Fainelli/net-stmmac-Fix-reception-of-Broadcom-switches-tags/20180120-044006
config: x86_64-randconfig-x002-201802 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:5:0,
                    from arch/x86/include/asm/bug.h:82,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/net//ethernet/stmicro/stmmac/dwmac4_core.c:17:
   drivers/net//ethernet/stmicro/stmmac/dwmac4_core.c: In function 'dwmac4_core_init':
   drivers/net//ethernet/stmicro/stmmac/dwmac4_core.c:36:6: error: implicit declaration of function 'netdev_uses_dsa'; did you mean 'netdev_reset_tc'? [-Werror=implicit-function-declaration]
     if (netdev_uses_dsa(dev))
         ^
   include/linux/compiler.h:58:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/net//ethernet/stmicro/stmmac/dwmac4_core.c:36:2: note: in expansion of macro 'if'
     if (netdev_uses_dsa(dev))
     ^~
   drivers/net//ethernet/stmicro/stmmac/dwmac4_core.c:37:13: error: 'GMAC_CONTROL_ACS' undeclared (first use in this function); did you mean 'GMAC_CONFIG_ACS'?
      value &= ~GMAC_CONTROL_ACS;
                ^~~~~~~~~~~~~~~~
                GMAC_CONFIG_ACS
   drivers/net//ethernet/stmicro/stmmac/dwmac4_core.c:37:13: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/asm-generic/bug.h:5:0,
                    from arch/x86/include/asm/bug.h:82,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/net//ethernet/stmicro/stmmac/dwmac4_core.c:17:
   drivers/net//ethernet/stmicro/stmmac/dwmac4_core.c: At top level:
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:425:2: note: in expansion of macro 'if'
     if (p_size == (size_t)-1 && q_size == (size_t)-1)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:415:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:413:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:404:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:402:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:393:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:391:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:383:2: note: in expansion of macro 'if'
     if (p_size < size || q_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:380:3: note: in expansion of macro 'if'
      if (q_size < size)
      ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'

vim +/if +36 drivers/net//ethernet/stmicro/stmmac/dwmac4_core.c

  > 17	#include <linux/slab.h>
    18	#include <linux/ethtool.h>
    19	#include <linux/io.h>
    20	#include "stmmac_pcs.h"
    21	#include "dwmac4.h"
    22	
    23	static void dwmac4_core_init(struct mac_device_info *hw,
    24				     struct net_device *dev)
    25	{
    26		void __iomem *ioaddr = hw->pcsr;
    27		u32 value = readl(ioaddr + GMAC_CONFIG);
    28		int mtu = dev->mtu;
    29	
    30		value |= GMAC_CORE_INIT;
    31	
    32		/* Clear ACS bit because Ethernet switch tagging formats such as
    33		 * Broadcom tags can look like invalid LLC/SNAP packets and cause the
    34		 * hardware to truncate packets on reception.
    35		 */
  > 36		if (netdev_uses_dsa(dev))
    37			value &= ~GMAC_CONTROL_ACS;
    38	
    39		if (mtu > 1500)
    40			value |= GMAC_CONFIG_2K;
    41		if (mtu > 2000)
    42			value |= GMAC_CONFIG_JE;
    43	
    44		if (hw->ps) {
    45			value |= GMAC_CONFIG_TE;
    46	
    47			value &= hw->link.speed_mask;
    48			switch (hw->ps) {
    49			case SPEED_1000:
    50				value |= hw->link.speed1000;
    51				break;
    52			case SPEED_100:
    53				value |= hw->link.speed100;
    54				break;
    55			case SPEED_10:
    56				value |= hw->link.speed10;
    57				break;
    58			}
    59		}
    60	
    61		writel(value, ioaddr + GMAC_CONFIG);
    62	
    63		/* Mask GMAC interrupts */
    64		value = GMAC_INT_DEFAULT_MASK;
    65		if (hw->pmt)
    66			value |= GMAC_INT_PMT_EN;
    67		if (hw->pcs)
    68			value |= GMAC_PCS_IRQ_DEFAULT;
    69	
    70		writel(value, ioaddr + GMAC_INT_EN);
    71	}
    72	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34542 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180120/64e4a3e3/attachment-0001.gz>
