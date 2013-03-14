From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 14 Mar 2013 11:44:32 +0800
Subject: [Suggestion] Latest randconfig build errors for CONFIG_MMU=no
Message-ID: <514147A0.2060002@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maintainers:

  when use randconfig:
    make V=1 EXTRA_CFLAGS=-W ARCH=arm randconfig
      (and "grep CONFIG_MMU .config" outputs "# CONFIG_MMU is not set")

  the error information:
    arch/arm/kernel/suspend.c: ????cpu_suspend??:
    arch/arm/kernel/suspend.c:56:32: ???????????????
    arch/arm/kernel/suspend.c:70:3: ??????????cpu_switch_mm? [-Werror=implicit-function-declaration]
    arch/arm/kernel/suspend.c:71:3: ??????????local_flush_bp_all? [-Werror=implicit-function-declaration]
    arch/arm/kernel/suspend.c:72:3: ??????????local_flush_tlb_all? [-Werror=implicit-function-declaration]

  I want to be sure whether we can bear it ?

  thanks.

-- 
Chen Gang

Asianux Corporation
