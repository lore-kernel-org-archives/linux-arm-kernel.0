From: lkp@intel.com (kbuild test robot)
Date: Thu, 23 Nov 2017 10:34:24 +0800
Subject: [PATCH V5 10/12] clk: sprd: add clocks support for SC9860
In-Reply-To: <20171120060137.27380-11-chunyan.zhang@spreadtrum.com>
References: <20171120060137.27380-11-chunyan.zhang@spreadtrum.com>
Message-ID: <201711230950.T3TiGuSx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chunyan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.14 next-20171122]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chunyan-Zhang/add-clock-driver-for-Spreadtrum-platforms/20171123-072852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

>> drivers/clk/sprd/sc9860-clk.c:128:18: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
    static const u64 const itable1[4] = {3, 780000000, 988000000, 1196000000};
                     ^~~~~
   drivers/clk/sprd/sc9860-clk.c:133:35: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
    static const struct clk_bit_field const f_mpll0[PLL_FACT_MAX] = {
                                      ^~~~~
   drivers/clk/sprd/sc9860-clk.c:150:35: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
    static const struct clk_bit_field const f_mpll1[PLL_FACT_MAX] = {
                                      ^~~~~
   drivers/clk/sprd/sc9860-clk.c:166:35: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
    static const struct clk_bit_field const f_dpll[PLL_FACT_MAX] = {
                                      ^~~~~
   drivers/clk/sprd/sc9860-clk.c:185:35: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
    static const struct clk_bit_field const f_rpll[PLL_FACT_MAX] = {
                                      ^~~~~
   drivers/clk/sprd/sc9860-clk.c:204:35: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
    static const struct clk_bit_field const f_twpll[PLL_FACT_MAX] = {
                                      ^~~~~
   drivers/clk/sprd/sc9860-clk.c:220:35: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
    static const struct clk_bit_field const f_ltepll[PLL_FACT_MAX] = {
                                      ^~~~~
   drivers/clk/sprd/sc9860-clk.c:240:35: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
    static const struct clk_bit_field const f_gpll[PLL_FACT_MAX] = {
                                      ^~~~~
   drivers/clk/sprd/sc9860-clk.c:257:35: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
    static const struct clk_bit_field const f_cppll[PLL_FACT_MAX] = {
                                      ^~~~~

vim +/const +128 drivers/clk/sprd/sc9860-clk.c

   126	
   127	/* GPLL/LPLL/DPLL/RPLL/CPLL */
 > 128	static const u64 const itable1[4] = {3, 780000000, 988000000, 1196000000};
   129	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36946 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171123/6795d49f/attachment-0001.gz>
