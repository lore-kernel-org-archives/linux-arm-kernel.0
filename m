From: lkp@intel.com (kbuild test robot)
Date: Fri, 18 May 2018 00:31:57 +0800
Subject: [PATCH v7 03/14] clk: qcom: Add CPU clock driver for msm8996
In-Reply-To: <1526375616-16904-4-git-send-email-ilialin@codeaurora.org>
References: <1526375616-16904-4-git-send-email-ilialin@codeaurora.org>
Message-ID: <201805172306.Un6aKldO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ilia,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.17-rc5]
[cannot apply to clk/clk-next next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ilia-Lin/CPU-scaling-support-for-msm8996/20180516-064721
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

>> drivers/clk/qcom/clk-cpu-8996.c:142:2: warning: this decimal constant is unsigned only in ISO C90
     VCO(0, 1000000000, 2150400000),
     ^~~

vim +142 drivers/clk/qcom/clk-cpu-8996.c

   137	
   138	static const struct pll_vco alt_pll_vco_modes[] = {
   139		VCO(3,  250000000,  500000000),
   140		VCO(2,  500000000,  750000000),
   141		VCO(1,  750000000, 1000000000),
 > 142		VCO(0, 1000000000, 2150400000),
   143	};
   144	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52971 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180518/8304b1ad/attachment-0001.gz>
