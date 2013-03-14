From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 14 Mar 2013 11:46:36 +0800
Subject: [Suggestion] Latest randconfig build errors for CONFIG_MMU=no
In-Reply-To: <514147A0.2060002@asianux.com>
References: <514147A0.2060002@asianux.com>
Message-ID: <5141481C.7050002@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


also has additional information (maybe useful):

  arch/arm/kernel/entry-armv.S:404:2: ???#warning "NPTL on non MMU needs fixing" [-Wcpp]
  arch/arm/kernel/entry-armv.S:867:2: ???#warning "NPTL on non MMU needs fixing" [-Wcpp]
  arch/arm/kernel/entry-armv.S:940:2: ???#warning "NPTL on non MMU needs fixing" [-Wcpp]


? 2013?03?14? 11:44, Chen Gang ??:
> Hello Maintainers:
> 
>   when use randconfig:
>     make V=1 EXTRA_CFLAGS=-W ARCH=arm randconfig
>       (and "grep CONFIG_MMU .config" outputs "# CONFIG_MMU is not set")
> 
>   the error information:
>     arch/arm/kernel/suspend.c: ????cpu_suspend??:
>     arch/arm/kernel/suspend.c:56:32: ???????????????
>     arch/arm/kernel/suspend.c:70:3: ??????????cpu_switch_mm? [-Werror=implicit-function-declaration]
>     arch/arm/kernel/suspend.c:71:3: ??????????local_flush_bp_all? [-Werror=implicit-function-declaration]
>     arch/arm/kernel/suspend.c:72:3: ??????????local_flush_tlb_all? [-Werror=implicit-function-declaration]
> 
>   I want to be sure whether we can bear it ?
> 
>   thanks.
> 


-- 
Chen Gang

Asianux Corporation
