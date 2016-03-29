From: lkp@intel.com (kbuild test robot)
Date: Tue, 29 Mar 2016 15:59:00 +0800
Subject: [PATCH 2/2] ARM: uniphier: initialize outer cache for secondary
 CPUs
In-Reply-To: <1459215505-18035-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <201603291505.HKmOMR4P%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

[auto build test WARNING on arm-soc/for-next]
[also build test WARNING on v4.6-rc1 next-20160329]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/ARM-uniphier-fix-up-cache-ops-broadcast-of-ACTLR/20160329-094052
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.text+0x557b4): Section mismatch in reference from the function uniphier_cache_secondary_init() to the function .init.text:uniphier_cache_activate_all_ways()
   The function uniphier_cache_secondary_init() references
   the function __init uniphier_cache_activate_all_ways().
   This is often because uniphier_cache_secondary_init lacks a __init
   annotation or the annotation of uniphier_cache_activate_all_ways is wrong.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 56597 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/fcd77fe1/attachment-0001.obj>
