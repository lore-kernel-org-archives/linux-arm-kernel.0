From: jamie@jamieiles.com (Jamie Iles)
Date: Sun, 9 Oct 2011 18:25:51 +0100
Subject: [PATCH 9/9] ARM: SPMP8000: Add Kconfig and Makefile entries to
	build the machine
In-Reply-To: <1318178172-7965-10-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-10-git-send-email-zoss@devai.org>
Message-ID: <20111009172551.GC18424@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zoltan,

On Sun, Oct 09, 2011 at 06:36:12PM +0200, Zoltan Devai wrote:
> Signed-off-by: Zoltan Devai <zoss@devai.org>
> ---
>  arch/arm/Kconfig  |   16 ++++++++++++++++
>  arch/arm/Makefile |    1 +
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9426e26..f34f10d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -831,6 +831,22 @@ config ARCH_SHARK
>  	  Support for the StrongARM based Digital DNARD machine, also known
>  	  as "Shark" (<http://www.shark-linux.de/shark.html>).
>  
> +config ARCH_SPMP8000
> +	bool "Sunplus SPMP8000"
> +	select CPU_ARM926T
> +	select ARM_VIC
> +	select GENERIC_IRQ_CHIP
> +	select MULTI_IRQ_HANDLER
> +	select CLKSRC_MMIO
> +	select GENERIC_CLOCKEVENTS
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> +	select USE_OF
> +	select CLKDEV_LOOKUP
> +	select HAVE_PWM
> +	select ARCH_HAS_CPUFREQ

I can't see anything using cpufreq yet so perhaps this can be removed 
for now?

Jamie
