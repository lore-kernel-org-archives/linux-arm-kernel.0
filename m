From: lkp@intel.com (kbuild test robot)
Date: Thu, 25 Aug 2016 18:31:48 +0800
Subject: [PATCH 01/10] reset: ath79: add driver Kconfig option
In-Reply-To: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <201608251826.2MYolse5%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

[auto build test ERROR on pza/reset/next]
[also build test ERROR on v4.8-rc3 next-20160824]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Philipp-Zabel/reset-ath79-add-driver-Kconfig-option/20160824-213846
base:   git://git.pengutronix.de/git/pza/linux reset/next
config: blackfin-allyesconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 4.6.3
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All errors (new ones prefixed by >>):

   drivers/reset/reset-ath79.c: In function 'ath79_reset_update':
>> drivers/reset/reset-ath79.c:38:2: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
>> drivers/reset/reset-ath79.c:43:2: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
   cc1: some warnings being treated as errors

vim +/readl +38 drivers/reset/reset-ath79.c

ff591a91 Alban Bedel 2015-08-03  32  	struct ath79_reset *ath79_reset =
ff591a91 Alban Bedel 2015-08-03  33  		container_of(rcdev, struct ath79_reset, rcdev);
ff591a91 Alban Bedel 2015-08-03  34  	unsigned long flags;
ff591a91 Alban Bedel 2015-08-03  35  	u32 val;
ff591a91 Alban Bedel 2015-08-03  36  
ff591a91 Alban Bedel 2015-08-03  37  	spin_lock_irqsave(&ath79_reset->lock, flags);
ff591a91 Alban Bedel 2015-08-03 @38  	val = readl(ath79_reset->base);
ff591a91 Alban Bedel 2015-08-03  39  	if (assert)
ff591a91 Alban Bedel 2015-08-03  40  		val |= BIT(id);
ff591a91 Alban Bedel 2015-08-03  41  	else
ff591a91 Alban Bedel 2015-08-03  42  		val &= ~BIT(id);
ff591a91 Alban Bedel 2015-08-03 @43  	writel(val, ath79_reset->base);
ff591a91 Alban Bedel 2015-08-03  44  	spin_unlock_irqrestore(&ath79_reset->lock, flags);
ff591a91 Alban Bedel 2015-08-03  45  
ff591a91 Alban Bedel 2015-08-03  46  	return 0;

:::::: The code at line 38 was first introduced by commit
:::::: ff591a91225d3621a503bb18faa0f0d747a06e50 reset: Add a driver for the reset controller on the AR71XX/AR9XXX

:::::: TO: Alban Bedel <albeu@free.fr>
:::::: CC: Philipp Zabel <p.zabel@pengutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 41344 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160825/073e47c9/attachment-0001.obj>
