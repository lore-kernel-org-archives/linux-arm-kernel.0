From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 27 Oct 2016 06:42:37 +0800
Subject: [rjarzmik:work/ac97 8/13] sound/soc/codecs/wm9713.c:20:30: fatal
 error: linux/mfd/wm97xx.h: No such file or directory
Message-ID: <201610270634.EVYQ07c7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux work/ac97
head:   223e9c527c425b1b519468e54fff9f4f82a7f390
commit: ded8ecc42087f1cdc4e356f118ea2e0d51691001 [8/13] ASoC: wm9713: add ac97 new bus support
config: m32r-allyesconfig (attached as .config)
compiler: m32r-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ded8ecc42087f1cdc4e356f118ea2e0d51691001
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

Note: the rjarzmik/work/ac97 HEAD 223e9c527c425b1b519468e54fff9f4f82a7f390 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> sound/soc/codecs/wm9713.c:20:30: fatal error: linux/mfd/wm97xx.h: No such file or directory
    #include <linux/mfd/wm97xx.h>
                                 ^
   compilation terminated.

vim +20 sound/soc/codecs/wm9713.c

    14	 *   o Support for AC97 Codec, Voice DAC and Aux DAC
    15	 *   o Support for DAPM
    16	 */
    17	
    18	#include <linux/init.h>
    19	#include <linux/slab.h>
  > 20	#include <linux/mfd/wm97xx.h>
    21	#include <linux/module.h>
    22	#include <linux/device.h>
    23	#include <linux/regmap.h>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37174 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161027/e80c0cd2/attachment-0001.gz>
