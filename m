From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 9 Oct 2012 00:25:44 -0400 (EDT)
Subject: ARM_ATAG_DTB_COMPAT fails on fdt_ro.c compiling
In-Reply-To: <20121009031715.GC21822@S2101-09.ap.freescale.net>
References: <20121009031715.GC21822@S2101-09.ap.freescale.net>
Message-ID: <alpine.LFD.2.02.1210090018470.16518@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Oct 2012, Shawn Guo wrote:

> I have seen this error on mainline for a couple days when
> ARM_ATAG_DTB_COMPAT is enabled.
> 
>   CC      arch/arm/boot/compressed/fdt_ro.o
> arch/arm/boot/compressed/fdt_ro.c: In function ?fdt_path_offset?:
> arch/arm/boot/compressed/fdt_ro.c:172:3: error: implicit declaration of function ?fdt_get_alias_namelen? [-Werror=implicit-function-declaration]
> arch/arm/boot/compressed/fdt_ro.c:172:5: warning: assignment makes pointer from integer without a cast [enabled by default]
> arch/arm/boot/compressed/fdt_ro.c: At top level:
> arch/arm/boot/compressed/fdt_ro.c:340:13: error: conflicting types for ?fdt_get_alias_namelen?
> arch/arm/boot/compressed/fdt_ro.c:172:7: note: previous implicit declaration of ?fdt_get_alias_namelen? was here
> cc1: some warnings being treated as errors

I just tried building mainline now.  It is at commit f5a246eab9.

  [...]
  CC      arch/arm/boot/compressed/misc.o
  CC      arch/arm/boot/compressed/decompress.o
  CC      arch/arm/boot/compressed/string.o
  SHIPPED arch/arm/boot/compressed/fdt_rw.c
  SHIPPED arch/arm/boot/compressed/fdt.h
  SHIPPED arch/arm/boot/compressed/libfdt.h
  SHIPPED arch/arm/boot/compressed/libfdt_internal.h
  CC      arch/arm/boot/compressed/fdt_rw.o
  SHIPPED arch/arm/boot/compressed/fdt_ro.c
  CC      arch/arm/boot/compressed/fdt_ro.o
  SHIPPED arch/arm/boot/compressed/fdt_wip.c
  CC      arch/arm/boot/compressed/fdt_wip.o
  SHIPPED arch/arm/boot/compressed/fdt.c
  CC      arch/arm/boot/compressed/fdt.o
  CC      arch/arm/boot/compressed/atags_to_fdt.o
  SHIPPED arch/arm/boot/compressed/lib1funcs.S
  AS      arch/arm/boot/compressed/lib1funcs.o
  SHIPPED arch/arm/boot/compressed/ashldi3.S
  AS      arch/arm/boot/compressed/ashldi3.o
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready

What config do you use?


Nicolas
