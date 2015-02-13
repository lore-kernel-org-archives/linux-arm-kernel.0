From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 13 Feb 2015 11:05:31 +0800
Subject: [PATCH 07/11] ARM: prima2: do not select SMP_ON_UP
In-Reply-To: <1423770163-583064-8-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-8-git-send-email-arnd@arndb.de>
Message-ID: <CAGsJ_4yP27EHF+MGw5gpZ8MNyJWV3HpPn=RS1PetfWOHVhF9EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-13 3:42 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> The new Atlas7 platform implicitly selects 'CONFIG_SMP_ON_UP',
> which leads to problems if we enable building the platform without
> MMU, as that combination is not allowed and causes a link error:
>
> arch/arm/kernel/built-in.o: In function `c_show':
> :(.text+0x1872): undefined reference to `smp_on_up'
> :(.text+0x1876): undefined reference to `smp_on_up'
> arch/arm/kernel/built-in.o: In function `arch_irq_work_raise':
> :(.text+0x3d48): undefined reference to `smp_on_up'
> :(.text+0x3d4c): undefined reference to `smp_on_up'
> arch/arm/kernel/built-in.o: In function `smp_setup_processor_id':
> :(.init.text+0x180): undefined reference to `smp_on_up'
>
> This removes the 'select' statement.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4cba058526a7 ("ARM: sirf: add Atlas7 machine support")
> Cc: Zhiwu Song <Zhiwu.Song@csr.com>
> Cc: Barry Song <Baohua.Song@csr.com>
> ---
>  arch/arm/mach-prima2/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Barry Song <Baohua.Song@csr.com>

>
> diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
> index a219dc310d5d..e03d8b5c9ad0 100644
> --- a/arch/arm/mach-prima2/Kconfig
> +++ b/arch/arm/mach-prima2/Kconfig
> @@ -27,7 +27,6 @@ config ARCH_ATLAS7
>         select CPU_V7
>         select HAVE_ARM_SCU if SMP
>         select HAVE_SMP
> -       select SMP_ON_UP if SMP
>         help
>            Support for CSR SiRFSoC ARM Cortex A7 Platform
>
> --
> 2.1.0.rc2
>

-barry
