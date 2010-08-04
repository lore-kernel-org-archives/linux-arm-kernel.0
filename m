From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Wed, 04 Aug 2010 12:55:36 +0200
Subject: Define CROSS_COMPILE in .config (kernel 2.6.35)
Message-ID: <4C594728.9020607@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Has anyone tried this option? If I define my CROSS_COMPILE prefix in .config and then call

make ARCH=arm

then I get following errors:

  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: ?include/generated/mach-types.h? ist bereits aktualisiert.
  CC      kernel/bounds.s
cc1: error: unrecognized command line option "-mlittle-endian"
cc1: error: unrecognized command line option "-mabi=aapcs-linux"
cc1: error: unrecognized command line option "-mno-thumb-interwork"
kernel/bounds.c:1: error: bad value (armv4t) for -march= switch
kernel/bounds.c:1: error: bad value (arm9tdmi) for -mtune= switch

the CROSS_COMPILE seems to be ignored. But if I comment the empty CROSS_COMPILE entry in Makefile

#CROSS_COMPILE   ?=
CROSS_COMPILE   ?= $(CONFIG_CROSS_COMPILE:"%"=%)

everything is working like a charm. Am I missing something?

Regards,
Yegor
