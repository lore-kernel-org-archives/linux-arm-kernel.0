From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Jul 2014 15:13:42 +0100
Subject: arch/arm64/efi-stub.o rebuilding every time?
Message-ID: <20140703141342.GB14305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

If I build an arm64 kernel, then simply hit make again without changing
anything, I find that efi-stub.o is rebuilt every time (with an annoying
warning too, but I think you already know about that):


$ make ARCH=arm64 CROSS_COMPILE=aarch64-none-linux-gnu- -j8 Image
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      arch/arm64/kernel/efi-stub.o
In file included from arch/arm64/kernel/efi-stub.c:44:0:
arch/arm64/kernel/../../../drivers/firmware/efi/fdt.c: In function ?update_fdt?:
arch/arm64/kernel/../../../drivers/firmware/efi/fdt.c:66:22: warning: unused variable ?name? [-Wunused-variable]
   const char *type, *name;
                      ^
  CHK     kernel/config_data.h
  LD      arch/arm64/kernel/built-in.o
  LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
  KSYM    .tmp_kallsyms1.o
  KSYM    .tmp_kallsyms2.o
  LD      vmlinux
  SORTEX  vmlinux
  SYSMAP  System.map
  OBJCOPY arch/arm64/boot/Image


Does this actually need to be rebuilt, or is there a buggy Makefile
somewhere?

Will
