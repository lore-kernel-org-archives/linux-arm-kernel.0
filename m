From: lkp@intel.com (kbuild test robot)
Date: Tue, 9 Feb 2016 11:31:09 +0800
Subject: [PATCH 04/14] clk: Add clk_hw OF clk providers
In-Reply-To: <1454982341-22715-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <201602091142.gNVJRY1Y%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

[auto build test ERROR on ljones-mfd/for-mfd-next]
[also build test ERROR on v4.5-rc3 next-20160208]
[cannot apply to clk/clk-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/clk_hw-based-clkdev-DT-providers/20160209-095211
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
config: x86_64-rhel (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/clk/clk.o: In function `of_clk_hw_simple_get':
>> (.text+0x3ec0): multiple definition of `of_clk_hw_simple_get'
   drivers/clk/clkdev.o:(.text+0x3e0): first defined here
   drivers/clk/clk.o: In function `of_clk_hw_onecell_get':
>> (.text+0x3ee0): multiple definition of `of_clk_hw_onecell_get'
   drivers/clk/clkdev.o:(.text+0x400): first defined here
   drivers/clk/clk.o: In function `of_clk_add_hw_provider':
>> (.text+0x3eb0): multiple definition of `of_clk_add_hw_provider'
   drivers/clk/clkdev.o:(.text+0x3d0): first defined here
   drivers/clk/clk-divider.o: In function `of_clk_hw_simple_get':
   (.text+0xb20): multiple definition of `of_clk_hw_simple_get'
   drivers/clk/clkdev.o:(.text+0x3e0): first defined here
   drivers/clk/clk-divider.o: In function `of_clk_hw_onecell_get':
   (.text+0xb40): multiple definition of `of_clk_hw_onecell_get'
   drivers/clk/clkdev.o:(.text+0x400): first defined here
   drivers/clk/clk-divider.o: In function `of_clk_add_hw_provider':
   (.text+0xb10): multiple definition of `of_clk_add_hw_provider'
   drivers/clk/clkdev.o:(.text+0x3d0): first defined here
   drivers/clk/clk-fixed-factor.o: In function `of_clk_hw_simple_get':
   (.text+0x170): multiple definition of `of_clk_hw_simple_get'
   drivers/clk/clkdev.o:(.text+0x3e0): first defined here
   drivers/clk/clk-fixed-factor.o: In function `of_clk_hw_onecell_get':
   (.text+0x190): multiple definition of `of_clk_hw_onecell_get'
   drivers/clk/clkdev.o:(.text+0x400): first defined here
   drivers/clk/clk-fixed-factor.o: In function `of_clk_add_hw_provider':
   (.text+0x160): multiple definition of `of_clk_add_hw_provider'
   drivers/clk/clkdev.o:(.text+0x3d0): first defined here
   drivers/clk/clk-fixed-rate.o: In function `of_clk_hw_simple_get':
   (.text+0x120): multiple definition of `of_clk_hw_simple_get'
   drivers/clk/clkdev.o:(.text+0x3e0): first defined here
   drivers/clk/clk-fixed-rate.o: In function `of_clk_hw_onecell_get':
   (.text+0x140): multiple definition of `of_clk_hw_onecell_get'
   drivers/clk/clkdev.o:(.text+0x400): first defined here
   drivers/clk/clk-fixed-rate.o: In function `of_clk_add_hw_provider':
   (.text+0x110): multiple definition of `of_clk_add_hw_provider'
   drivers/clk/clkdev.o:(.text+0x3d0): first defined here
   drivers/clk/clk-gate.o: In function `of_clk_hw_simple_get':
   (.text+0x280): multiple definition of `of_clk_hw_simple_get'
   drivers/clk/clkdev.o:(.text+0x3e0): first defined here
   drivers/clk/clk-gate.o: In function `of_clk_hw_onecell_get':
   (.text+0x2a0): multiple definition of `of_clk_hw_onecell_get'
   drivers/clk/clkdev.o:(.text+0x400): first defined here
   drivers/clk/clk-gate.o: In function `of_clk_add_hw_provider':
   (.text+0x270): multiple definition of `of_clk_add_hw_provider'
   drivers/clk/clkdev.o:(.text+0x3d0): first defined here
   drivers/clk/clk-multiplier.o: In function `of_clk_hw_simple_get':
   (.text+0x2b0): multiple definition of `of_clk_hw_simple_get'
   drivers/clk/clkdev.o:(.text+0x3e0): first defined here
   drivers/clk/clk-multiplier.o: In function `of_clk_hw_onecell_get':
   (.text+0x2d0): multiple definition of `of_clk_hw_onecell_get'
   drivers/clk/clkdev.o:(.text+0x400): first defined here
   drivers/clk/clk-multiplier.o: In function `of_clk_add_hw_provider':
   (.text+0x2a0): multiple definition of `of_clk_add_hw_provider'
   drivers/clk/clkdev.o:(.text+0x3d0): first defined here
   drivers/clk/clk-mux.o: In function `of_clk_hw_simple_get':
   (.text+0x340): multiple definition of `of_clk_hw_simple_get'
   drivers/clk/clkdev.o:(.text+0x3e0): first defined here
   drivers/clk/clk-mux.o: In function `of_clk_hw_onecell_get':
   (.text+0x360): multiple definition of `of_clk_hw_onecell_get'
   drivers/clk/clkdev.o:(.text+0x400): first defined here
   drivers/clk/clk-mux.o: In function `of_clk_add_hw_provider':
   (.text+0x330): multiple definition of `of_clk_add_hw_provider'
   drivers/clk/clkdev.o:(.text+0x3d0): first defined here
   drivers/clk/clk-composite.o: In function `of_clk_add_hw_provider':
   clk-composite.c:(.text+0x3a0): multiple definition of `of_clk_add_hw_provider'
   drivers/clk/clkdev.o:(.text+0x3d0): first defined here
   drivers/clk/clk-composite.o: In function `of_clk_hw_simple_get':
   clk-composite.c:(.text+0x3b0): multiple definition of `of_clk_hw_simple_get'
   drivers/clk/clkdev.o:(.text+0x3e0): first defined here
   drivers/clk/clk-composite.o: In function `of_clk_hw_onecell_get':
   clk-composite.c:(.text+0x3d0): multiple definition of `of_clk_hw_onecell_get'
   drivers/clk/clkdev.o:(.text+0x400): first defined here
   drivers/clk/clk-fractional-divider.o: In function `of_clk_hw_simple_get':
   (.text+0x330): multiple definition of `of_clk_hw_simple_get'
   drivers/clk/clkdev.o:(.text+0x3e0): first defined here
   drivers/clk/clk-fractional-divider.o: In function `of_clk_hw_onecell_get':
   (.text+0x350): multiple definition of `of_clk_hw_onecell_get'
   drivers/clk/clkdev.o:(.text+0x400): first defined here
   drivers/clk/clk-fractional-divider.o: In function `of_clk_add_hw_provider':
   (.text+0x320): multiple definition of `of_clk_add_hw_provider'
   drivers/clk/clkdev.o:(.text+0x3d0): first defined here
   drivers/clk/clk-gpio.o: In function `of_clk_hw_simple_get':
   (.text+0x340): multiple definition of `of_clk_hw_simple_get'
   drivers/clk/clkdev.o:(.text+0x3e0): first defined here
   drivers/clk/clk-gpio.o: In function `of_clk_hw_onecell_get':
   (.text+0x360): multiple definition of `of_clk_hw_onecell_get'
   drivers/clk/clkdev.o:(.text+0x400): first defined here
   drivers/clk/clk-gpio.o: In function `of_clk_add_hw_provider':
   (.text+0x330): multiple definition of `of_clk_add_hw_provider'
   drivers/clk/clkdev.o:(.text+0x3d0): first defined here
   drivers/clk/x86/built-in.o: In function `of_clk_hw_simple_get':
   (.text+0x90): multiple definition of `of_clk_hw_simple_get'
   drivers/clk/clkdev.o:(.text+0x3e0): first defined here
   drivers/clk/x86/built-in.o: In function `of_clk_hw_onecell_get':
   (.text+0xb0): multiple definition of `of_clk_hw_onecell_get'
   drivers/clk/clkdev.o:(.text+0x400): first defined here
   drivers/clk/x86/built-in.o: In function `of_clk_add_hw_provider':
   (.text+0x80): multiple definition of `of_clk_add_hw_provider'
   drivers/clk/clkdev.o:(.text+0x3d0): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36062 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/4189771e/attachment-0001.obj>
