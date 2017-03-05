From: lkp@intel.com (kbuild test robot)
Date: Sun, 5 Mar 2017 09:08:59 +0800
Subject: [PATCHv2 07/14] drm: Use set_memory.h header
In-Reply-To: <1488413706-9739-8-git-send-email-labbott@redhat.com>
Message-ID: <201703050814.HBH8sHGi%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

[auto build test ERROR on linus/master]
[also build test ERROR on next-20170303]
[cannot apply to tip/x86/core drm/drm-next v4.10]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Laura-Abbott/set_memory_-functions-header-refactor/20170305-062939
config: ia64-defconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

>> drivers/char/agp/generic.c:42:28: fatal error: asm/set_memory.h: No such file or directory
    #include <asm/set_memory.h>
                               ^
   compilation terminated.
--
>> drivers/gpu/drm/radeon/radeon_gart.c:30:28: fatal error: asm/set_memory.h: No such file or directory
    #include <asm/set_memory.h>
                               ^
   compilation terminated.
--
>> drivers/gpu/drm/ttm/ttm_tt.c:47:28: fatal error: asm/set_memory.h: No such file or directory
    #include <asm/set_memory.h>
                               ^
   compilation terminated.
--
>> drivers/gpu/drm/ttm/ttm_page_alloc.c:54:28: fatal error: asm/set_memory.h: No such file or directory
    #include <asm/set_memory.h>
                               ^
   compilation terminated.
--
>> drivers/gpu/drm/ttm/ttm_page_alloc_dma.c:56:28: fatal error: asm/set_memory.h: No such file or directory
    #include <asm/set_memory.h>
                               ^
   compilation terminated.

vim +30 drivers/gpu/drm/radeon/radeon_gart.c

    24	 * Authors: Dave Airlie
    25	 *          Alex Deucher
    26	 *          Jerome Glisse
    27	 */
    28	#include <drm/drmP.h>
    29	#include <drm/radeon_drm.h>
  > 30	#include <asm/set_memory.h>
    31	#include "radeon.h"
    32	
    33	/*

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 18382 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170305/7cd31440/attachment-0001.gz>
