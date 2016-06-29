From: lkp@intel.com (kbuild test robot)
Date: Thu, 30 Jun 2016 02:05:44 +0800
Subject: [PATCH V2 6/8] clk: imx: add clk api for supporting
 CLK_OPS_PARENT_ENABLE clocks
In-Reply-To: <1467212351-16626-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <201606300245.tqgN8XJk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.7-rc5 next-20160629]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-core-support-clocks-which-requires-parents-enable/20160629-231445
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-imx_v6_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   In file included from drivers/clk/imx/clk.c:6:0:
   drivers/clk/imx/clk.h: In function 'imx_clk_divider2':
>> drivers/clk/imx/clk.h:104:26: error: 'CLK_OPS_PARENT_ON' undeclared (first use in this function)
       CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ON,
                             ^
   drivers/clk/imx/clk.h:104:26: note: each undeclared identifier is reported only once for each function it appears in
   drivers/clk/imx/clk.h: In function 'imx_clk_gate3':
   drivers/clk/imx/clk.h:148:26: error: 'CLK_OPS_PARENT_ON' undeclared (first use in this function)
       CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ON,
                             ^
   drivers/clk/imx/clk.h: In function 'imx_clk_gate4':
   drivers/clk/imx/clk.h:156:26: error: 'CLK_OPS_PARENT_ON' undeclared (first use in this function)
       CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ON,
                             ^
   drivers/clk/imx/clk.h: In function 'imx_clk_mux2':
   drivers/clk/imx/clk.h:172:31: error: 'CLK_OPS_PARENT_ON' undeclared (first use in this function)
       CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ON,
                                  ^

vim +/CLK_OPS_PARENT_ON +104 drivers/clk/imx/clk.h

    98	}
    99	
   100	static inline struct clk *imx_clk_divider2(const char *name, const char *parent,
   101			void __iomem *reg, u8 shift, u8 width)
   102	{
   103		return clk_register_divider(NULL, name, parent,
 > 104				CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ON,
   105				reg, shift, width, 0, &imx_ccm_lock);
   106	}
   107	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 29841 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/f1bb8c90/attachment-0001.obj>
