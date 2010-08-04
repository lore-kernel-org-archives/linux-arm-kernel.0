From: hongjiujing@126.com (tommy.hong)
Date: Wed, 04 Aug 2010 11:05:56 -0000
Subject: Define CROSS_COMPILE in .config (kernel 2.6.35)
In-Reply-To: <4C594728.9020607@visionsystems.de>
References: <4C594728.9020607@visionsystems.de>
Message-ID: <2c1fc037.1d87d.12a3cc6927d.Coremail.hongjiujing@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi:
##Linux-src/Makefile:
ARCH            := arm
CROSS_COMPILE   := $(shell if [ -f .cross_compile ]; then \
                                cat .cross_compile; \
                                fi)
#.cross_compile
arm-poky-linux-gnueabi-

B.R
Tommy
--

our psychological growth is the movement from dependence to independence  to
interdependence!



At 2010-08-04?"Yegor Yefremov" <yegor_sub1@visionsystems.de> wrote:

>Has anyone tried this option? If I define my CROSS_COMPILE prefix in .config and then call
>
>make ARCH=arm
>
>then I get following errors:
>
>  CHK     include/linux/version.h
>  CHK     include/generated/utsrelease.h
>make[1]: ?include/generated/mach-types.h? ist bereits aktualisiert.
>  CC      kernel/bounds.s
>cc1: error: unrecognized command line option "-mlittle-endian"
>cc1: error: unrecognized command line option "-mabi=aapcs-linux"
>cc1: error: unrecognized command line option "-mno-thumb-interwork"
>kernel/bounds.c:1: error: bad value (armv4t) for -march= switch
>kernel/bounds.c:1: error: bad value (arm9tdmi) for -mtune= switch
>
>the CROSS_COMPILE seems to be ignored. But if I comment the empty CROSS_COMPILE entry in Makefile
>
>#CROSS_COMPILE   ?=
>CROSS_COMPILE   ?= $(CONFIG_CROSS_COMPILE:"%"=%)
>
>everything is working like a charm. Am I missing something?
>
>Regards,
>Yegor
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100804/48297454/attachment-0001.html>
