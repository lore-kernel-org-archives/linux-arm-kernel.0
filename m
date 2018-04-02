From: lkp@intel.com (kbuild test robot)
Date: Tue, 3 Apr 2018 02:53:21 +0800
Subject: [PATCH v5 4/5] arm64: introduce pfn_valid_region()
In-Reply-To: <1522636236-12625-5-git-send-email-hejianet@gmail.com>
References: <1522636236-12625-5-git-send-email-hejianet@gmail.com>
Message-ID: <201804030205.AP5IhRJn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jia,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16 next-20180329]
[cannot apply to arm64/for-next/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jia-He/optimize-memblock_next_valid_pfn-and-early_pfn_valid-on-arm-and-arm64/20180402-131223
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.text+0x39c4c): Section mismatch in reference from the function pfn_valid_region() to the variable .meminit.data:$d
   The function pfn_valid_region() references
   the variable __meminitdata $d.
   This is often because pfn_valid_region lacks a __meminitdata
   annotation or the annotation of $d is wrong.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58864 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/04ea4a88/attachment-0001.gz>
