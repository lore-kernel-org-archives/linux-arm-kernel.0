From: lkp@intel.com (kbuild test robot)
Date: Sat, 18 Feb 2017 22:14:47 +0800
Subject: [PATCH 4/4] ARM: davinci: add pdata-quirks for da850-evm vpif
 display
In-Reply-To: <1487269285-6948-5-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <201702182235.FIVcD9i5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

[auto build test ERROR on arm-soc/for-next]
[also build test ERROR on next-20170217]
[cannot apply to v4.10-rc8]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/ARM-davinci-vpif-capture-display-support/20170217-044437
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-davinci_all_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-davinci/pdata-quirks.c: In function 'da850_vpif_legacy_init':
>> arch/arm/mach-davinci/pdata-quirks.c:184:38: error: 'da850_vpif_display_config' undeclared (first use in this function)
      ret = da850_register_vpif_display(&da850_vpif_display_config);
                                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-davinci/pdata-quirks.c:184:38: note: each undeclared identifier is reported only once for each function it appears in

vim +/da850_vpif_display_config +184 arch/arm/mach-davinci/pdata-quirks.c

   178		if (ret)
   179			pr_warn("%s: VPIF capture setup failed: %d\n",
   180				__func__, ret);
   181	
   182		/* LCDK doesn't support VPIF display */
   183		if (of_machine_is_compatible("ti,da850-evm")) {
 > 184			ret = da850_register_vpif_display(&da850_vpif_display_config);
   185			if (ret)
   186				pr_warn("%s: VPIF display setup failed: %d\n",
   187					__func__, ret);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23948 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170218/026dd944/attachment-0001.gz>
