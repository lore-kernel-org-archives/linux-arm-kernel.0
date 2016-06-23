From: lkp@intel.com (kbuild test robot)
Date: Thu, 23 Jun 2016 23:26:36 +0800
Subject: [PATCH 1/2] mm: memblock Add some new functions to address the
 mem limit issue
In-Reply-To: <1466681415-8058-1-git-send-email-dennis.chen@arm.com>
Message-ID: <201606232319.4gbhuXin%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on v4.7-rc4 next-20160623]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dennis-Chen/mm-memblock-Add-some-new-functions-to-address-the-mem-limit-issue/20160623-193344
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/core
config: x86_64-randconfig-s0-06232144 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

>> WARNING: vmlinux.o(.text.unlikely+0x330c): Section mismatch in reference from the function __find_max_addr() to the variable .meminit.data:memblock
   The function __find_max_addr() references
   the variable __meminitdata memblock.
   This is often because __find_max_addr lacks a __meminitdata
   annotation or the annotation of memblock is wrong.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21054 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160623/f10dbdcd/attachment-0001.obj>
