From: lkp@intel.com (kbuild test robot)
Date: Sat, 1 Sep 2018 06:37:34 +0800
Subject: [PATCH 2/4] media: meson: add v4l2 m2m video decoder driver
In-Reply-To: <20180831085205.14760-3-mjourdan@baylibre.com>
References: <20180831085205.14760-3-mjourdan@baylibre.com>
Message-ID: <201809010545.xve78pjt%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.19-rc1 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maxime-Jourdan/Add-Amlogic-video-decoder-driver/20180901-033653
base:   git://linuxtv.org/media_tree.git master
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from drivers/media/platform/meson/vdec/esparser.h:10:0,
                    from drivers/media/platform/meson/vdec/esparser.c:21:
>> drivers/media/platform/meson/vdec/vdec.h:18:10: fatal error: linux/soc/amlogic/meson-canvas.h: No such file or directory
    #include <linux/soc/amlogic/meson-canvas.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +18 drivers/media/platform/meson/vdec/vdec.h

    12	
    13	#include <linux/regmap.h>
    14	#include <linux/list.h>
    15	#include <media/videobuf2-v4l2.h>
    16	#include <media/v4l2-ctrls.h>
    17	#include <media/v4l2-device.h>
  > 18	#include <linux/soc/amlogic/meson-canvas.h>
    19	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65146 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180901/69109668/attachment-0001.gz>
