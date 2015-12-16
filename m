From: lkp@intel.com (kbuild test robot)
Date: Wed, 16 Dec 2015 18:55:12 +0800
Subject: [PATCH 1/5] clk: rockchip: rk3036: include downstream muxes into
 fractional dividers
In-Reply-To: <1450254441-3243-2-git-send-email-wxt@rock-chips.com>
Message-ID: <201512161806.QILxofnO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on next-20151216]
[cannot apply to clk/clk-next v4.4-rc5]

url:    https://github.com/0day-ci/linux/commits/Caesar-Wang/Kylin-board-is-based-on-RK3036-SOCs-add-the-initiation/20151216-163233
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-multi_v7_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

>> drivers/clk/rockchip/clk-rk3036.c:230:2: error: implicit declaration of function 'COMPOSITE_FRACMUX' [-Werror=implicit-function-declaration]
     COMPOSITE_FRACMUX(0, "uart0_frac", "uart0_src", CLK_SET_RATE_PARENT,
     ^
   In file included from drivers/clk/rockchip/clk-rk3036.c:24:0:
>> drivers/clk/rockchip/clk.h:412:2: error: expected expression before '{' token
     {       \
     ^
>> drivers/clk/rockchip/clk-rk3036.c:233:2: note: in expansion of macro 'MUX'
     MUX(SCLK_UART0, "sclk_uart0", mux_uart0_p, CLK_SET_RATE_PARENT,
     ^
>> drivers/clk/rockchip/clk.h:412:2: error: expected expression before '{' token
     {       \
     ^
   drivers/clk/rockchip/clk-rk3036.c:238:2: note: in expansion of macro 'MUX'
     MUX(SCLK_UART1, "sclk_uart1", mux_uart1_p, CLK_SET_RATE_PARENT,
     ^
>> drivers/clk/rockchip/clk.h:412:2: error: expected expression before '{' token
     {       \
     ^
   drivers/clk/rockchip/clk-rk3036.c:243:2: note: in expansion of macro 'MUX'
     MUX(SCLK_UART2, "sclk_uart2", mux_uart2_p, CLK_SET_RATE_PARENT,
     ^
>> drivers/clk/rockchip/clk.h:412:2: error: expected expression before '{' token
     {       \
     ^
   drivers/clk/rockchip/clk-rk3036.c:295:2: note: in expansion of macro 'MUX'
     MUX(0, "i2s_pre", mux_i2s_pre_p, CLK_SET_RATE_PARENT,
     ^
>> drivers/clk/rockchip/clk.h:412:2: error: expected expression before '{' token
     {       \
     ^
   drivers/clk/rockchip/clk-rk3036.c:309:2: note: in expansion of macro 'MUX'
     MUX(SCLK_SPDIF, "sclk_spdif", mux_spdif_p, 0,
     ^
   cc1: some warnings being treated as errors

vim +/COMPOSITE_FRACMUX +230 drivers/clk/rockchip/clk-rk3036.c

   224		COMPOSITE_NOMUX(0, "uart1_src", "uart_pll_clk", 0,
   225				RK2928_CLKSEL_CON(13), 0, 7, DFLAGS,
   226				RK2928_CLKGATE_CON(1), 8, GFLAGS),
   227		COMPOSITE_NOMUX(0, "uart2_src", "uart_pll_clk", 0,
   228				RK2928_CLKSEL_CON(13), 0, 7, DFLAGS,
   229				RK2928_CLKGATE_CON(1), 8, GFLAGS),
 > 230		COMPOSITE_FRACMUX(0, "uart0_frac", "uart0_src", CLK_SET_RATE_PARENT,
   231				RK2928_CLKSEL_CON(17), 0,
   232				RK2928_CLKGATE_CON(1), 9, GFLAGS,
 > 233		MUX(SCLK_UART0, "sclk_uart0", mux_uart0_p, CLK_SET_RATE_PARENT,
   234				RK2928_CLKSEL_CON(13), 8, 2, MFLAGS)),
   235		COMPOSITE_FRACMUX(0, "uart1_frac", "uart1_src", CLK_SET_RATE_PARENT,
   236				RK2928_CLKSEL_CON(18), 0,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 35436 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151216/830cca2d/attachment-0001.obj>
