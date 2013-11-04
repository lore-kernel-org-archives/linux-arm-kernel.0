From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Mon, 04 Nov 2013 10:05:49 +0100
Subject: [PATCH] ARM: iop3xx: remove unused MACH_EP80219 Kconfig parameter
In-Reply-To: <1383555042-4135-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1383555042-4135-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <5277636D.8050204@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2013 09:50 AM, Michael Opdenacker wrote:
> This removes the MACH_EP80219 Kconfig parameter,
> which was no longer used anywhere in the source code
> and Makefiles.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
> ---
>  arch/arm/mach-iop32x/Kconfig | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm/mach-iop32x/Kconfig b/arch/arm/mach-iop32x/Kconfig
> index 5e8c6f7dfabb..65f3500258e5 100644
> --- a/arch/arm/mach-iop32x/Kconfig
> +++ b/arch/arm/mach-iop32x/Kconfig
> @@ -4,9 +4,6 @@ menu "IOP32x Implementation Options"
>  
>  comment "IOP32x Platform Types"
>  
> -config MACH_EP80219
> -	bool
> -
>  config MACH_GLANTANK
>  	bool "Enable support for the IO-Data GLAN Tank"
>  	help
> @@ -22,7 +19,6 @@ config ARCH_IQ80321
>  
>  config ARCH_IQ31244
>  	bool "Enable support for EP80219/IQ31244"
> -	select MACH_EP80219
>  	help
>  	  Say Y here if you want to run your kernel on the Intel EP80219
>  	  evaluation kit for the Intel 80219 processor (a IOP321 variant)
Actually, in another thread, Sascha Hauer made me realize that this
symbol is actually used to make machine_is_ep80219() become true when
the kernel is started with the corresponding machine id.

Let's drop this patch.

Michael.

-- 
Michael Opdenacker, CEO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
+33 484 258 098
