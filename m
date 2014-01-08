From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Thu, 09 Jan 2014 00:03:23 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2M10gQVJNOiBpbXg6IGFkZCBzZWxlY3Qgb24gQVJDSF9N?=
 =?UTF-8?B?WEMgZm9yIGNwdWZyZXEgc3VwcG9ydA==?=
In-Reply-To: <1389210991-23688-1-git-send-email-john.tobias.ph@gmail.com>
References: <1389210991-23688-1-git-send-email-john.tobias.ph@gmail.com>
Message-ID: <1389211403.678513817@f123.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

?????,  8 ?????? 2014, 11:56 -08:00 ?? John Tobias <john.tobias.ph@gmail.com>:
> Moved ARCH_HAS_CPUFREQ, HAVE_IMX_ANATOP and PM_OPP on ARCH_MXC so that
> the user can enable the cpufreq support for iMX6Q and/or iMX6SL.
> 
> Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
> ---
>  arch/arm/mach-imx/Kconfig | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 7a6e6f7..3c326be 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -1,5 +1,6 @@
>  config ARCH_MXC
>  	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
> +	select ARCH_HAS_CPUFREQ
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ARM_CPU_SUSPEND if PM
>  	select ARM_PATCH_PHYS_VIRT
> @@ -9,8 +10,10 @@ config ARCH_MXC
>  	select GENERIC_ALLOCATOR
>  	select GENERIC_CLOCKEVENTS
>  	select GENERIC_IRQ_CHIP
> +	select HAVE_IMX_ANATOP

Maybe better:
select HAVE_IMX_ANATOP if ARCH_MULTI_V6_V7

---
