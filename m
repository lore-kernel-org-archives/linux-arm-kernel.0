From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 27 Mar 2013 19:44:03 +0800
Subject: [Suggestion] ARM64:kernel: compiling issue for early_console.
Message-ID: <5152DB83.8080703@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maintainers:

  it is a compiling issue for early_console.

  the make command:
    make V=1 EXTRA_CFLAGS=-W ARCH=arm64 allmodconfig
    make V=1 EXTRA_CFLAGS=-W ARCH=arm64 menuconfig
      set aarch64-linux-gnu- for tool chain prefix.
    make V=1 EXTRA_CFLAGS=-W ARCH=arm64

  the error message:
    arch/arm64/kernel/early_printk.c: At top level:
    arch/arm64/kernel/early_printk.c:98:23: error: conflicting types for ?early_console?
    In file included from arch/arm64/kernel/early_printk.c:20:0:
    include/linux/console.h:145:24: note: previous declaration of ?early_console? was here
    make[1]: *** [arch/arm64/kernel/early_printk.o] Error 1
    make: *** [arch/arm64/kernel] Error 2


  I guess, we can just reference the 32-bit arm implementation is ok.
    (it is in arch/arm/kernel/early_printk.c line 32..44)

  if really just like what I guess, may I send related patch for it ?

  :-)


gchen.
