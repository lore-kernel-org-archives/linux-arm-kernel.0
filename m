From: lkp@intel.com (kbuild test robot)
Date: Wed, 18 Jul 2018 00:09:48 +0800
Subject: [PATCH v5 10/11] clk: mediatek: Add MT6765 clock support
In-Reply-To: <1531817552-17221-11-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-11-git-send-email-mars.cheng@mediatek.com>
Message-ID: <201807180025.FNytrCxn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Owen,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.18-rc5 next-20180717]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mars-Cheng/Add-basic-SoC-support-for-mt6765/20180717-205540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/clk/mediatek/clk-mt6765-vcodec.c:75:21: error: 'of_match_clk_mt6765_vcodec' undeclared here (not in a function); did you mean 'of_match_clk_mt6765_venc'?
      .of_match_table = of_match_clk_mt6765_vcodec,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
                        of_match_clk_mt6765_venc

vim +75 drivers/clk/mediatek/clk-mt6765-vcodec.c

    70	
    71	static struct platform_driver clk_mt6765_vcodec_drv = {
    72		.probe = clk_mt6765_vcodec_probe,
    73		.driver = {
    74			.name = "clk-mt6765-vcodec",
  > 75			.of_match_table = of_match_clk_mt6765_vcodec,
    76		},
    77	};
    78	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64183 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180718/3c2eee28/attachment-0001.gz>
