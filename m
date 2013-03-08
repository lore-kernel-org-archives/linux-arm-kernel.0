From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri, 8 Mar 2013 13:31:30 +0530
Subject: asm/types.h Header file wont get generated while building uImage ?
Message-ID: <CA+V-a8vYsBLVH-3Bm35Sv9K9ZMTcMB4_P_V3kBjyuEKDozPi5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Usually for building uImage I follow this steps,
1: do a clean distclean
2: make ARCH=arm CROSS_COMPILE=xxx   xxxdefconfig
3: make ARCH=arm CROSS_COMPILE=xxx  uImage

This used to work until 3.8, for 3.9 I see the following error:

  HOSTCC  scripts/genksyms/parse.tab.o
In file included from include/linux/types.h:5:0,
                 from include/linux/mod_devicetable.h:11,
                 from scripts/mod/devicetable-offsets.c:2:
include/uapi/linux/types.h:4:23: fatal error: asm/types.h: No such
file or directory
compilation terminated.

Well this get fixed if do  make ARCH=arm
CROSS_COMPILE=arm-none-linux-gnueabi- headers_install
and the build the uImage.

Is it the same way now its going to be followed or is it I am missing
something ?
(For  reference I have used da8xx_omapl_defconfig config when I faced
this issue)

Regards,
--Prabhakar
