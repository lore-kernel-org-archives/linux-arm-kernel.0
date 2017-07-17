From: lkp@intel.com (kbuild test robot)
Date: Mon, 17 Jul 2017 23:25:55 +0800
Subject: [PATCH] iommu/exynos: Replace non-existing big-endian Kconfig
 option
In-Reply-To: <1500270422-4805-1-git-send-email-krzk@kernel.org>
Message-ID: <201707172340.xpsuGzYj%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

[auto build test WARNING on iommu/next]
[also build test WARNING on v4.13-rc1 next-20170717]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/iommu-exynos-Replace-non-existing-big-endian-Kconfig-option/20170717-141202
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

>> drivers//iommu/exynos-iommu.c:58:2: warning: #warning "revisit driver if we can enable big-endian ptes" [-Wcpp]
    #warning "revisit driver if we can enable big-endian ptes"
     ^~~~~~~

vim +58 drivers//iommu/exynos-iommu.c

2a96536e KyongHo Cho         2012-05-12  56  
61dfd0bc Krzysztof Kozlowski 2017-07-17  57  #ifdef CONFIG_CPU_BIG_ENDIAN
6ae5343c Ben Dooks           2016-06-08 @58  #warning "revisit driver if we can enable big-endian ptes"
6ae5343c Ben Dooks           2016-06-08  59  #endif
6ae5343c Ben Dooks           2016-06-08  60  

:::::: The code at line 58 was first introduced by commit
:::::: 6ae5343c26f9cba5e9ef8ba6f23b5bb255ebc798 iommu/exynos: update to use iommu big-endian

:::::: TO: Ben Dooks <ben.dooks@codethink.co.uk>
:::::: CC: Joerg Roedel <jroedel@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62409 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170717/9af14339/attachment-0001.gz>
