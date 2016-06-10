From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 10 Jun 2016 21:21:42 +0800
Subject: [clk:clk-s905 5/17] drivers/clk/meson/meson8b-clkc.c:407:39: error:
 'meson8b_a5_clk' undeclared
Message-ID: <201606102140.ZLyAT5Wh%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-s905
head:   14205b63b3a68189f828849c16ee62c4a4d0d8f0
commit: f8343e7ae0f2a9dc004abf61ba647ffa1b55f4c3 [5/17] clk: meson8b: clean up cpu clocks
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f8343e7ae0f2a9dc004abf61ba647ffa1b55f4c3
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the clk/clk-s905 HEAD 14205b63b3a68189f828849c16ee62c4a4d0d8f0 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/clk/meson/meson8b-clkc.c: In function 'meson8b_clkc_init':
>> drivers/clk/meson/meson8b-clkc.c:407:39: error: 'meson8b_a5_clk' undeclared (first use in this function)
     clk_notifier_unregister(parent_clk, &meson8b_a5_clk.clk_nb);
                                          ^
   drivers/clk/meson/meson8b-clkc.c:407:39: note: each undeclared identifier is reported only once for each function it appears in

vim +/meson8b_a5_clk +407 drivers/clk/meson/meson8b-clkc.c

   401					ARRAY_SIZE(meson8b_clk_confs),
   402					clk_base);
   403		return;
   404	
   405	/* FIXME remove after converting to platform_driver/devm_clk_register */
   406	unregister_clk_nb:
 > 407		clk_notifier_unregister(parent_clk, &meson8b_a5_clk.clk_nb);
   408	unregister:
   409		for (clkid = CLK_NR_CLKS - 1; clkid >= 0; clkid--)
   410			clk_hw_unregister(meson8b_hw_onecell_data.hws[clkid]);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 57596 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/a6db9a78/attachment-0001.obj>
