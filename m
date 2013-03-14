From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 14 Mar 2013 13:25:56 +0000
Subject: [Suggestion] Latest randconfig build errors for CONFIG_MMU=no
In-Reply-To: <514147A0.2060002@asianux.com>
References: <514147A0.2060002@asianux.com>
Message-ID: <5141CFE4.2030909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen,

On 14/03/13 03:44, Chen Gang wrote:
> Hello Maintainers:
>
>    when use randconfig:
>      make V=1 EXTRA_CFLAGS=-W ARCH=arm randconfig
>        (and "grep CONFIG_MMU .config" outputs "# CONFIG_MMU is not set")
>
>    the error information:
>      arch/arm/kernel/suspend.c: ????cpu_suspend??:
>      arch/arm/kernel/suspend.c:56:32: ???????????????
>      arch/arm/kernel/suspend.c:70:3: ??????????cpu_switch_mm? [-Werror=implicit-function-declaration]
>      arch/arm/kernel/suspend.c:71:3: ??????????local_flush_bp_all? [-Werror=implicit-function-declaration]
>      arch/arm/kernel/suspend.c:72:3: ??????????local_flush_tlb_all? [-Werror=implicit-function-declaration]
>
>    I want to be sure whether we can bear it ?
>

You're right that at the moment that suspend code is broken for NOMMU.

However, Will Deacon has a patch to fix it in his nommu branch on 
kernel.org:

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=nommu

I'll let Will comment on how/when he might look at proposing that code 
to be merged.

Jonny
