From: lkp@intel.com (kbuild test robot)
Date: Mon, 1 Jan 2018 22:47:11 +0800
Subject: [PATCH 01/33] clk_ops: change round_rate() to return unsigned long
In-Reply-To: <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
References: <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <201801012236.kquIizPb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tegra/for-next]
[also build test WARNING on v4.15-rc6]
[cannot apply to clk/clk-next next-20171222]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bryan-O-Donoghue/change-clk_ops-round_rate-to-scale-past-LONG_MAX/20180101-212907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: i386-randconfig-b0-01011934 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

>> drivers/clk/clk-versaclock5.c:321:2: warning: initialization from incompatible pointer type
     .round_rate = vc5_dbl_round_rate,
     ^
   drivers/clk/clk-versaclock5.c:321:2: warning: (near initialization for 'vc5_dbl_ops.round_rate')

vim +321 drivers/clk/clk-versaclock5.c

8c1ebe97 Marek Vasut 2017-07-09  318  
8c1ebe97 Marek Vasut 2017-07-09  319  static const struct clk_ops vc5_dbl_ops = {
8c1ebe97 Marek Vasut 2017-07-09  320  	.recalc_rate	= vc5_dbl_recalc_rate,
8c1ebe97 Marek Vasut 2017-07-09 @321  	.round_rate	= vc5_dbl_round_rate,
8c1ebe97 Marek Vasut 2017-07-09  322  	.set_rate	= vc5_dbl_set_rate,
8c1ebe97 Marek Vasut 2017-07-09  323  };
8c1ebe97 Marek Vasut 2017-07-09  324  

:::::: The code at line 321 was first introduced by commit
:::::: 8c1ebe9762670159ca982167131af63c94ff1571 clk: vc5: Add support for the input frequency doubler

:::::: TO: Marek Vasut <marek.vasut@gmail.com>
:::::: CC: Stephen Boyd <sboyd@codeaurora.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27230 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180101/941c6843/attachment-0001.gz>
