From: lkp@intel.com (kbuild test robot)
Date: Fri, 25 Dec 2015 08:56:53 +0800
Subject: [PATCH 1/3] ARM: ATAGS: move atags.h to include/asm so it can be
 included by files outside kernel/
In-Reply-To: <1450965658-2675-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <201512250816.bPnwSXzT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
Hi Ivaylo,

[auto build test ERROR on omap/for-next]
[also build test ERROR on v4.4-rc6 next-20151223]

url:    https://github.com/0day-ci/linux/commits/Ivaylo-Dimitrov/OMAP-RX51-save-atags-data-to-be-exported-on-proc-atags/20151224-220541
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git for-next
config: arm-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> arch/arm/kernel/atags_compat.c:29:19: fatal error: atags.h: No such file or directory
    #include "atags.h"
                      ^
   compilation terminated.

vim +29 arch/arm/kernel/atags_compat.c

^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  13   * NOTE:
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  14   *  The old struct param_struct is deprecated, but it will be kept in
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  15   *  the kernel for 5 years from now (2001). This will allow boot loaders
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  16   *  to convert to the new struct tag way.
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  17   */
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  18  #include <linux/types.h>
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  19  #include <linux/kernel.h>
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  20  #include <linux/string.h>
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  21  #include <linux/init.h>
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  22  
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  23  #include <asm/setup.h>
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  24  #include <asm/mach-types.h>
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  25  #include <asm/page.h>
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  26  
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  27  #include <asm/mach/arch.h>
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  28  
aa783b6f arch/arm/kernel/atags_compat.c Nicolas Pitre  2012-09-01 @29  #include "atags.h"
0fc1c832 arch/arm/kernel/compat.c       Ben Dooks      2006-03-15  30  
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  31  /*
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  32   * Usage:
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  33   *  - do not go blindly adding fields, add them at the end
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  34   *  - when adding fields, don't rely on the address until
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  35   *    a patch from me has been released
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  36   *  - unused fields should be zero (for future expansion)
^1da177e arch/arm/kernel/compat.c       Linus Torvalds 2005-04-16  37   *  - this structure is relatively short-lived - only

:::::: The code at line 29 was first introduced by commit
:::::: aa783b6fd60b3844e199b1c2d2f4068f3caa1358 ARM: 7505/1: split out ATAGS parsing

:::::: TO: Nicolas Pitre <nicolas.pitre@linaro.org>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53927 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151225/0cf70633/attachment-0001.obj>
