From: lkp@intel.com (kbuild test robot)
Date: Thu, 13 Sep 2018 00:10:12 +0800
Subject: [PATCH v2 2/3] media: meson: add v4l2 m2m video decoder driver
In-Reply-To: <20180911150938.3844-3-mjourdan@baylibre.com>
References: <20180911150938.3844-3-mjourdan@baylibre.com>
Message-ID: <201809130028.L3S7wSGr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.19-rc3 next-20180912]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maxime-Jourdan/dt-bindings-media-add-Amlogic-Video-Decoder-Bindings/20180912-193603
base:   git://linuxtv.org/media_tree.git master
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from drivers/media/platform/meson/vdec/esparser.h:12:0,
                    from drivers/media/platform/meson/vdec/esparser.c:20:
>> drivers/media/platform/meson/vdec/vdec.h:15:10: fatal error: linux/soc/amlogic/meson-canvas.h: No such file or directory
    #include <linux/soc/amlogic/meson-canvas.h>
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

vim +15 drivers/media/platform/meson/vdec/vdec.h

     9	
    10	#include <linux/regmap.h>
    11	#include <linux/list.h>
    12	#include <media/videobuf2-v4l2.h>
    13	#include <media/v4l2-ctrls.h>
    14	#include <media/v4l2-device.h>
  > 15	#include <linux/soc/amlogic/meson-canvas.h>
    16	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65148 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180913/691cfefa/attachment-0001.gz>
