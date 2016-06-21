From: lkp@intel.com (kbuild test robot)
Date: Wed, 22 Jun 2016 00:01:07 +0800
Subject: [PATCH 1/5] clk: rockchip: rk3228: fix incorrect clock node names
In-Reply-To: <1466484811-26923-2-git-send-email-zhengxing@rock-chips.com>
Message-ID: <201606212335.VFvzq20R%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.7-rc4 next-20160621]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Xing-Zheng/Fix-and-improve-clock-controller-for-the-RK322x-SoCs/20160621-130641
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/Xing-Zheng/Fix-and-improve-clock-controller-for-the-RK322x-SoCs/20160621-130641 HEAD 46fe9dec31bc488791124a6237caa95c0cd75a30 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

>> drivers/clk/rockchip/clk-rk3228.c:667:0: error: unterminated argument list invoking macro "COMPOSITE_FRAC"
    CLK_OF_DECLARE(rk3228_cru, "rockchip,rk3228-cru", rk3228_clk_init);
    ^
>> drivers/clk/rockchip/clk-rk3228.c:392:2: error: 'COMPOSITE_FRAC' undeclared here (not in a function)
     COMPOSITE_FRAC(0, "i2s1_frac", "i2s1_src", CLK_SET_RATE_PARENT,
     ^
>> drivers/clk/rockchip/clk-rk3228.c:392:2: error: expected '}' at end of input
>> drivers/clk/rockchip/clk-rk3228.c:104:42: warning: 'rk3228_cpuclk_rates' defined but not used [-Wunused-variable]
    static struct rockchip_cpuclk_rate_table rk3228_cpuclk_rates[] __initdata = {
                                             ^
>> drivers/clk/rockchip/clk-rk3228.c:158:34: warning: 'rk3228_pll_clks' defined but not used [-Wunused-variable]
    static struct rockchip_pll_clock rk3228_pll_clks[] __initdata = {
                                     ^
>> drivers/clk/rockchip/clk-rk3228.c:173:35: warning: 'rk3228_clk_branches' defined but not used [-Wunused-variable]
    static struct rockchip_clk_branch rk3228_clk_branches[] __initdata = {
                                      ^

vim +/COMPOSITE_FRAC +667 drivers/clk/rockchip/clk-rk3228.c

307a2e9ac Jeffy Chen 2015-12-11  661  				  ROCKCHIP_SOFTRST_HIWORD_MASK);
307a2e9ac Jeffy Chen 2015-12-11  662  
ef1d9feec Xing Zheng 2016-03-09  663  	rockchip_register_restart_notifier(ctx, RK3228_GLB_SRST_FST, NULL);
ef1d9feec Xing Zheng 2016-03-09  664  
ef1d9feec Xing Zheng 2016-03-09  665  	rockchip_clk_of_add_provider(np, ctx);
307a2e9ac Jeffy Chen 2015-12-11  666  }
307a2e9ac Jeffy Chen 2015-12-11 @667  CLK_OF_DECLARE(rk3228_cru, "rockchip,rk3228-cru", rk3228_clk_init);

:::::: The code at line 667 was first introduced by commit
:::::: 307a2e9ac524bbec707c0e2b47ca50adaecc23f2 clk: rockchip: add clock controller for rk3228

:::::: TO: Jeffy Chen <jeffy.chen@rock-chips.com>
:::::: CC: Heiko Stuebner <heiko@sntech.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25985 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160622/4dba437b/attachment-0001.obj>
