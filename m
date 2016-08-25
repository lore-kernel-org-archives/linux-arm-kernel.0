From: lkp@intel.com (kbuild test robot)
Date: Thu, 25 Aug 2016 14:56:12 +0800
Subject: [PATCH 2/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
In-Reply-To: <1472080984-17373-2-git-send-email-zach.brown@ni.com>
Message-ID: <201608251442.Eq8iwx18%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zach,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.8-rc3 next-20160824]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Zach-Brown/sdhci-of-arasan-Add-quirk-and-device-tree-parameter-to-fake-CD-bit/20160825-072554
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-of-arasan.c: In function 'sdhci_arasan_probe':
>> drivers/mmc/host/sdhci-of-arasan.c:539:12: error: 'struct sdhci_pltfm_host' has no member named 'priv'; did you mean 'private'?
     pltfm_host->priv = sdhci_arasan;
               ^~

vim +539 drivers/mmc/host/sdhci-of-arasan.c

   533		sdhci_get_of_property(pdev);
   534	
   535		if (of_get_property(pdev->dev.of_node, "fake-cd", NULL))
   536			host->quirks2 |= SDHCI_QUIRK2_NEED_FAKE_CD;
   537	
   538		pltfm_host = sdhci_priv(host);
 > 539		pltfm_host->priv = sdhci_arasan;
   540		pltfm_host->clk = clk_xin;
   541	
   542		sdhci_arasan_update_baseclkfreq(host);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 55503 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160825/0050a60d/attachment-0001.obj>
