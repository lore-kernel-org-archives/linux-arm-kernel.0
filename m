From: lkp@intel.com (kbuild test robot)
Date: Wed, 2 Aug 2017 23:50:39 +0800
Subject: [PATCH 1/3] mmc: sdhci: enable/disable the clock in
 sdhci_pltfm_suspend/resume
In-Reply-To: <1501505809-393-2-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <201708022332.VqGgwitn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.13-rc3 next-20170802]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/mmc-sdhci-enable-disable-the-clock-in-sdhci_pltfm_suspend-resume/20170801-021149
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/mmc/host/sdhci-sirf.c:242:21: error: initializer element is not constant
      .of_match_table = sdhci_pltfm_pmops,
                        ^~~~~~~~~~~~~~~~~
   drivers/mmc/host/sdhci-sirf.c:242:21: note: (near initialization for 'sdhci_sirf_driver.driver.of_match_table')
>> drivers/mmc/host/sdhci-sirf.c:243:10: error: 'sdhci_sirf_pm_ops' undeclared here (not in a function)
      .pm = &sdhci_sirf_pm_ops,
             ^~~~~~~~~~~~~~~~~

vim +242 drivers/mmc/host/sdhci-sirf.c

   238	
   239	static struct platform_driver sdhci_sirf_driver = {
   240		.driver		= {
   241			.name	= "sdhci-sirf",
 > 242			.of_match_table = sdhci_pltfm_pmops,
 > 243			.pm	= &sdhci_sirf_pm_ops,
   244		},
   245		.probe		= sdhci_sirf_probe,
   246		.remove		= sdhci_pltfm_unregister,
   247	};
   248	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63458 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170802/4a684794/attachment-0001.gz>
