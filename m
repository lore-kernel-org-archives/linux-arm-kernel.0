From: lkp@intel.com (kbuild test robot)
Date: Fri, 23 Mar 2018 14:49:24 +0800
Subject: [PATCH V2 3/4] clk: add managed version of clk_bulk_get_all
In-Reply-To: <1521602391-30356-4-git-send-email-aisheng.dong@nxp.com>
References: <1521602391-30356-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <201803231452.YBWTInPr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dong,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.16-rc6 next-20180322]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-new-APIs-to-handle-all-available-clocks/20180323-122451
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from include/linux/cpufreq.h:14:0,
                    from arch/powerpc/platforms/cell/cpufreq_spudemand.c:23:
   include/linux/clk.h:679:1: error: expected identifier or '(' before '{' token
    {
    ^
>> include/linux/clk.h:677:32: error: 'devm_clk_bulk_get_all' declared 'static' but never defined [-Werror=unused-function]
    static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
                                   ^~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +677 include/linux/clk.h

   676	
 > 677	static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
   678							     struct clk_bulk_data **clks);
 > 679	{
   680	
   681		return 0;
   682	}
   683	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24187 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180323/8215e30e/attachment-0001.gz>
