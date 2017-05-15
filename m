From: lkp@intel.com (kbuild test robot)
Date: Mon, 15 May 2017 17:10:14 +0800
Subject: [PATCH 3/3] clk: hi3660: Set PPLL2 to 2880M
In-Reply-To: <20170515055423.1803-3-guodong.xu@linaro.org>
Message-ID: <201705151623.5kc4IeTF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhong,

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.12-rc1 next-20170515]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Guodong-Xu/clk-hi3660-fix-wrong-parent-name-of-clk_mux_sysbus/20170515-135929
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

>> drivers/clk/hisilicon/clk-hi3660.c:23:2: warning: this decimal constant is unsigned only in ISO C90
     { HI3660_CLK_PPLL2, "clk_ppll2", NULL, 0, 2880000000, },
     ^

vim +23 drivers/clk/hisilicon/clk-hi3660.c

     7	 * the Free Software Foundation; either version 2 of the License, or
     8	 * (at your option) any later version.
     9	 */
    10	
    11	#include <dt-bindings/clock/hi3660-clock.h>
    12	#include <linux/clk-provider.h>
    13	#include <linux/of_device.h>
    14	#include <linux/platform_device.h>
    15	#include "clk.h"
    16	
    17	static const struct hisi_fixed_rate_clock hi3660_fixed_rate_clks[] = {
    18		{ HI3660_CLKIN_SYS, "clkin_sys", NULL, 0, 19200000, },
    19		{ HI3660_CLKIN_REF, "clkin_ref", NULL, 0, 32764, },
    20		{ HI3660_CLK_FLL_SRC, "clk_fll_src", NULL, 0, 128000000, },
    21		{ HI3660_CLK_PPLL0, "clk_ppll0", NULL, 0, 1600000000, },
    22		{ HI3660_CLK_PPLL1, "clk_ppll1", NULL, 0, 1866000000, },
  > 23		{ HI3660_CLK_PPLL2, "clk_ppll2", NULL, 0, 2880000000, },
    24		{ HI3660_CLK_PPLL3, "clk_ppll3", NULL, 0, 1290000000, },
    25		{ HI3660_CLK_SCPLL, "clk_scpll", NULL, 0, 245760000, },
    26		{ HI3660_PCLK, "pclk", NULL, 0, 20000000, },
    27		{ HI3660_CLK_UART0_DBG, "clk_uart0_dbg", NULL, 0, 19200000, },
    28		{ HI3660_CLK_UART6, "clk_uart6", NULL, 0, 19200000, },
    29		{ HI3660_OSC32K, "osc32k", NULL, 0, 32764, },
    30		{ HI3660_OSC19M, "osc19m", NULL, 0, 19200000, },
    31		{ HI3660_CLK_480M, "clk_480m", NULL, 0, 480000000, },

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61381 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170515/3c87ff16/attachment-0001.gz>
