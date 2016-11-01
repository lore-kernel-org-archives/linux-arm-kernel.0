From: lkp@intel.com (kbuild test robot)
Date: Tue, 1 Nov 2016 23:40:00 +0800
Subject: [PATCH/RESEND V4 2/3] ARM64 LPC: Add missing range exception for
 special ISA
In-Reply-To: <1478006926-240933-3-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201611012326.goMprgAU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.9-rc3 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/zhichang-yuan/ARM64-LPC-legacy-ISA-I-O-support/20161101-211425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm-efm32_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `__of_address_to_resource':
>> drivers/of/address.c:748: undefined reference to `pcibios_min_io'

vim +748 drivers/of/address.c

1f5bef30 Grant Likely   2010-06-08  742  		r->start = taddr;
1f5bef30 Grant Likely   2010-06-08  743  		r->end = taddr + size - 1;
1f5bef30 Grant Likely   2010-06-08  744  	}
1f5bef30 Grant Likely   2010-06-08  745  	r->flags = flags;
35f3da32 Benoit Cousson 2011-12-05  746  	r->name = name ? name : dev->full_name;
35f3da32 Benoit Cousson 2011-12-05  747  
1f5bef30 Grant Likely   2010-06-08 @748  	return 0;
1f5bef30 Grant Likely   2010-06-08  749  }
1f5bef30 Grant Likely   2010-06-08  750  
1f5bef30 Grant Likely   2010-06-08  751  /**

:::::: The code at line 748 was first introduced by commit
:::::: 1f5bef30cf6c66f097ea5dfc580a41924df888d1 of/address: merge of_address_to_resource()

:::::: TO: Grant Likely <grant.likely@secretlab.ca>
:::::: CC: Grant Likely <grant.likely@secretlab.ca>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 10888 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161101/12b0bc75/attachment.gz>
