From: lkp@intel.com (kbuild test robot)
Date: Tue, 1 Dec 2015 03:42:38 +0800
Subject: [PATCH] clk: sunxi: pll2: Fix clock running too fast
In-Reply-To: <1448897699-20475-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201512010345.CHh5KAWB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

[auto build test ERROR on: clk/clk-next]
[also build test ERROR on: v4.4-rc3 next-20151127]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/clk-sunxi-pll2-Fix-clock-running-too-fast/20151130-233840
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/clk/sunxi/clk-a10-pll2.c: In function 'sun4i_a10_pll2_setup':
>> drivers/clk/sunxi/clk-a10-pll2.c:191:26: error: 'sun4i_a10_pll2_data' undeclared (first use in this function)
     sun4i_pll2_setup(node, &sun4i_a10_pll2_data, 0);
                             ^
   drivers/clk/sunxi/clk-a10-pll2.c:191:26: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/clk/sunxi/clk-a10-pll2.c:191:2: error: too many arguments to function 'sun4i_pll2_setup'
     sun4i_pll2_setup(node, &sun4i_a10_pll2_data, 0);
     ^
   drivers/clk/sunxi/clk-a10-pll2.c:46:20: note: declared here
    static void __init sun4i_pll2_setup(struct device_node *node,
                       ^
   drivers/clk/sunxi/clk-a10-pll2.c: In function 'sun5i_a13_pll2_setup':
>> drivers/clk/sunxi/clk-a10-pll2.c:199:26: error: 'sun5i_a13_pll2_data' undeclared (first use in this function)
     sun4i_pll2_setup(node, &sun5i_a13_pll2_data, 1);
                             ^
   drivers/clk/sunxi/clk-a10-pll2.c:199:2: error: too many arguments to function 'sun4i_pll2_setup'
     sun4i_pll2_setup(node, &sun5i_a13_pll2_data, 1);
     ^
   drivers/clk/sunxi/clk-a10-pll2.c:46:20: note: declared here
    static void __init sun4i_pll2_setup(struct device_node *node,
                       ^

vim +/sun4i_a10_pll2_data +191 drivers/clk/sunxi/clk-a10-pll2.c

   185	err_unmap:
   186		iounmap(reg);
   187	}
   188	
   189	static void __init sun4i_a10_pll2_setup(struct device_node *node)
   190	{
 > 191		sun4i_pll2_setup(node, &sun4i_a10_pll2_data, 0);
   192	}
   193	
   194	CLK_OF_DECLARE(sun4i_a10_pll2, "allwinner,sun4i-a10-pll2-clk",
   195		       sun4i_a10_pll2_setup);
   196	
   197	static void __init sun5i_a13_pll2_setup(struct device_node *node)
   198	{
 > 199		sun4i_pll2_setup(node, &sun5i_a13_pll2_data, 1);
   200	}
   201	
   202	CLK_OF_DECLARE(sun5i_a13_pll2, "allwinner,sun5i-a13-pll2-clk",

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53968 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151201/6dec3c77/attachment-0001.obj>
