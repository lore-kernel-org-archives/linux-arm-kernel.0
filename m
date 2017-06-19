From: lkp@intel.com (kbuild test robot)
Date: Mon, 19 Jun 2017 08:13:26 +0800
Subject: [PATCH V1 6/9] clk: sprd: add composite clock support
In-Reply-To: <20170618015855.27738-7-chunyan.zhang@spreadtrum.com>
Message-ID: <201706190809.LMVHxP1c%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chunyan,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.12-rc5 next-20170616]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chunyan-Zhang/add-clock-driver-for-Spreadtrum-platforms/20170619-031614
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> drivers/clk/sunxi-ng/built-in.o:(.rodata+0x16080): multiple definition of `ccu_gate_ops'
   drivers/clk/sprd/built-in.o:(.rodata+0x160): first defined here
   drivers/clk/sunxi-ng/built-in.o: In function `ccu_mux_helper_set_parent':
>> ccu_frac.c:(.text+0x2ac8): multiple definition of `ccu_mux_helper_set_parent'
   drivers/clk/sprd/built-in.o:ccu_composite.c:(.text+0x810): first defined here
>> drivers/clk/sunxi-ng/built-in.o:(.rodata+0x162c0): multiple definition of `ccu_mux_ops'
   drivers/clk/sprd/built-in.o:(.rodata+0x260): first defined here
   drivers/clk/sunxi-ng/built-in.o: In function `ccu_mux_helper_get_parent':
>> ccu_frac.c:(.text+0x2950): multiple definition of `ccu_mux_helper_get_parent'
   drivers/clk/sprd/built-in.o:ccu_composite.c:(.text+0x650): first defined here
>> drivers/clk/sunxi-ng/built-in.o:(.rodata+0x15fc0): multiple definition of `ccu_div_ops'
   drivers/clk/sprd/built-in.o:(.rodata+0x360): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55798 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170619/198be1bd/attachment-0001.gz>
