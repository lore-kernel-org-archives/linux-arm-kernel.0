From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 19 Jan 2018 14:37:11 -0800
Subject: [PATCH net-next] net: stmmac: Fix reception of Broadcom switches
 tags
In-Reply-To: <201801200543.cKHnq3PE%fengguang.wu@intel.com>
References: <20180116232545.22054-1-f.fainelli@gmail.com>
 <201801200543.cKHnq3PE%fengguang.wu@intel.com>
Message-ID: <1fc8e687-882c-3700-02e2-cfc10fca95dc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2018 02:06 PM, kbuild test robot wrote:
> Hi Florian,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on net-next/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Florian-Fainelli/net-stmmac-Fix-reception-of-Broadcom-switches-tags/20180120-044006
> config: x86_64-randconfig-x002-201802 (attached as .config)
> compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/asm-generic/bug.h:5:0,
>                     from arch/x86/include/asm/bug.h:82,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/gfp.h:5,
>                     from include/linux/slab.h:15,
>                     from drivers/net//ethernet/stmicro/stmmac/dwmac4_core.c:17:
>    drivers/net//ethernet/stmicro/stmmac/dwmac4_core.c: In function 'dwmac4_core_init':
>    drivers/net//ethernet/stmicro/stmmac/dwmac4_core.c:36:6: error: implicit declaration of function 'netdev_uses_dsa'; did you mean 'netdev_reset_tc'? [-Werror=implicit-function-declaration]
>      if (netdev_uses_dsa(dev))

This was fixed in v2 that David applied, thanks!
-- 
Florian
