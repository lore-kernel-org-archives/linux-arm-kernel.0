From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 13 May 2014 12:07:54 +0200
Subject: [PATCH v3 1/2] ARM: EXYNOS: Map SYSRAM through generic SRAM
 bindings
In-Reply-To: <029b01cf6e59$35a452e0$a0ecf8a0$@samsung.com>
References: <1399522592-23618-1-git-send-email-sachin.kamat@linaro.org>
 <536BAE39.70504@samsung.com> <034b01cf6b2c$5b5d06b0$12171410$@samsung.com>
 <536C5E40.90405@gmail.com> <029b01cf6e59$35a452e0$a0ecf8a0$@samsung.com>
Message-ID: <1399975674.24871.19.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On Tue, 2014-05-13 at 12:12 +0900, Kukjin Kim wrote:
> Tomasz Figa wrote:
> > You mean s/sram/sysram/ in compatible strings of Exynos-specific
> > reserved areas? If yes, I'm fine, it might be even better. Just remember
> > to update documentation in patch 2/2 as well.
> > 
> Done. If any problems in my tree, please let me know.

It seems this one just hit linux-next (in next-20140513) as "ARM:
EXYNOS: Map SYSRAM through generic DT bindings". Its commit now contains
this hunk:
    --- a/arch/arm/Kconfig
    +++ b/arch/arm/Kconfig
    @@ -843,6 +843,7 @@ config ARCH_EXYNOS
            select HAVE_S3C_RTC if RTC_CLASS
            select NEED_MACH_MEMORY_H
            select SPARSE_IRQ
    +       select SYSRAM
            select USE_OF
            help
              Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)

But there's no Kconfig symbol SYSRAM. However, there is a Kconfig symbol
SRAM. Did you perhaps do one s/sram/sysram/ too many on the original
patch?


Paul Bolle
