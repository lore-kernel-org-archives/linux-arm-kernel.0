From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Jul 2016 15:57:45 +0800
Subject: [PATCH 03/13] clk: sunxi-ng: sun8i: Rename DDR and video plls
In-Reply-To: <20160726203041.29366-4-maxime.ripard@free-electrons.com>
Message-ID: <201607271553.cFusOPwu%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on next-20160726]
[cannot apply to v4.7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/arm64-Allwinner-A64-support-based-on-sunxi-ng/20160727-084745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/Maxime-Ripard/arm64-Allwinner-A64-support-based-on-sunxi-ng/20160727-084745 HEAD b4837ac76808c0a3584aef785ddfe74589c1b8fb builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> drivers/clk/sunxi-ng/ccu-sun8i-h3.c:620:23: error: 'pll_video_clk' undeclared here (not in a function)
      [CLK_PLL_VIDEO]  = &pll_video_clk.common.hw,
                          ^
>> drivers/clk/sunxi-ng/ccu-sun8i-h3.c:622:21: error: 'pll_ddr_clk' undeclared here (not in a function)
      [CLK_PLL_DDR]  = &pll_ddr_clk.common.hw,
                        ^

vim +/pll_video_clk +620 drivers/clk/sunxi-ng/ccu-sun8i-h3.c

0577e485 Maxime Ripard 2016-06-29  614  		[CLK_PLL_CPUX]		= &pll_cpux_clk.common.hw,
0577e485 Maxime Ripard 2016-06-29  615  		[CLK_PLL_AUDIO_BASE]	= &pll_audio_base_clk.common.hw,
0577e485 Maxime Ripard 2016-06-29  616  		[CLK_PLL_AUDIO]		= &pll_audio_clk.hw,
0577e485 Maxime Ripard 2016-06-29  617  		[CLK_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
0577e485 Maxime Ripard 2016-06-29  618  		[CLK_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
0577e485 Maxime Ripard 2016-06-29  619  		[CLK_PLL_AUDIO_8X]	= &pll_audio_8x_clk.hw,
0577e485 Maxime Ripard 2016-06-29 @620  		[CLK_PLL_VIDEO]		= &pll_video_clk.common.hw,
0577e485 Maxime Ripard 2016-06-29  621  		[CLK_PLL_VE]		= &pll_ve_clk.common.hw,
0577e485 Maxime Ripard 2016-06-29 @622  		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
0577e485 Maxime Ripard 2016-06-29  623  		[CLK_PLL_PERIPH0]	= &pll_periph0_clk.common.hw,
0577e485 Maxime Ripard 2016-06-29  624  		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.hw,
0577e485 Maxime Ripard 2016-06-29  625  		[CLK_PLL_GPU]		= &pll_gpu_clk.common.hw,

:::::: The code at line 620 was first introduced by commit
:::::: 0577e4853bfb4c65f620fa56d3157692df7f766e clk: sunxi-ng: Add H3 clocks

:::::: TO: Maxime Ripard <maxime.ripard@free-electrons.com>
:::::: CC: Michael Turquette <mturquette@baylibre.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 50253 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160727/6ed10be2/attachment-0001.obj>
