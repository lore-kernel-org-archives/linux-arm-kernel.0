From: lkp@intel.com (kbuild test robot)
Date: Thu, 27 Oct 2016 22:24:36 +0800
Subject: [PATCH] ARM: davinci: register the usb20_phy clock on the DT file
In-Reply-To: <20161026194916.14546-1-ahaslam@baylibre.com>
Message-ID: <201610272246.ICxa2YRq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

[auto build test ERROR on arm-soc/for-next]
[also build test ERROR on v4.9-rc2 next-20161027]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/ahaslam-baylibre-com/ARM-davinci-register-the-usb20_phy-clock-on-the-DT-file/20161027-040551
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-davinci_all_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-davinci/da8xx-dt.c: In function 'da850_init_machine':
>> arch/arm/mach-davinci/da8xx-dt.c:48:2: error: implicit declaration of function 'da8xx_register_usb20_phy_clk' [-Werror=implicit-function-declaration]
     da8xx_register_usb20_phy_clk(false);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm/mach-davinci/da8xx-dt.c:49:2: error: implicit declaration of function 'da8xx_register_usb11_phy_clk' [-Werror=implicit-function-declaration]
     da8xx_register_usb11_phy_clk(false);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/da8xx_register_usb20_phy_clk +48 arch/arm/mach-davinci/da8xx-dt.c

    42	};
    43	
    44	#ifdef CONFIG_ARCH_DAVINCI_DA850
    45	
    46	static void __init da850_init_machine(void)
    47	{
  > 48		da8xx_register_usb20_phy_clk(false);
  > 49		da8xx_register_usb11_phy_clk(false);
    50		of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
    51	}
    52	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 21064 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161027/615d600d/attachment-0001.gz>
