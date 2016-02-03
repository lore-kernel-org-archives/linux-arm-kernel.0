From: lkp@intel.com (kbuild test robot)
Date: Wed, 3 Feb 2016 10:23:42 +0800
Subject: [PATCH] clk: gpio: Make into a platform driver
In-Reply-To: <1454462520-20787-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <201602031053.Tb6b0qXh%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.5-rc2 next-20160202]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/clk-gpio-Make-into-a-platform-driver/20160203-092337
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: mips-maltaaprp_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All error/warnings (new ones prefixed by >>):

>> drivers/clk/clk-gpio.c:263:1: warning: data definition has no type or storage class
    MODULE_DEVICE_TABLE(of, gpio_clk_match_table);
    ^
>> drivers/clk/clk-gpio.c:263:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]
>> drivers/clk/clk-gpio.c:263:1: warning: parameter names (without types) in function declaration
   cc1: some warnings being treated as errors

vim +263 drivers/clk/clk-gpio.c

   257	
   258	static const struct of_device_id gpio_clk_match_table[] = {
   259		{ .compatible = "gpio-mux-clock" },
   260		{ .compatible = "gpio-gate-clock" },
   261		{ }
   262	};
 > 263	MODULE_DEVICE_TABLE(of, gpio_clk_match_table);
   264	
   265	static struct platform_driver gpio_clk_driver = {
   266		.probe		= gpio_clk_driver_probe,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 13851 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/719b8853/attachment-0001.obj>
