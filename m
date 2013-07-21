From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 22 Jul 2013 01:42:56 +0200
Subject: [PATCH 1/5] ARM: bcm4760: Add platform infrastructure
In-Reply-To: <20130721002713.512199844@gmail.com>
References: <20130721002320.730568671@gmail.com>
 <20130721002713.512199844@gmail.com>
Message-ID: <20130721234256.GA5537@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Christian Daudt  (Christian, you've not an entry in MAINTAINERS)

On Sun, Jul 21, 2013 at 02:23:21AM +0200, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> Platform infrastructure for the Broadcom BCM4760 based ARM11 SoCs.
> 
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> ---
> Index: b/arch/arm/Makefile
> ===================================================================
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -147,6 +147,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x0020
>  machine-$(CONFIG_ARCH_AT91)		+= at91
>  machine-$(CONFIG_ARCH_BCM)		+= bcm
>  machine-$(CONFIG_ARCH_BCM2835)		+= bcm2835
> +machine-$(CONFIG_ARCH_BCM4760)		+= bcm
>  machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
>  machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
>  machine-$(CONFIG_ARCH_DAVINCI)		+= davinci

I've noticed that enabling both CONFIG_ARCH_BCM and CONFIG_ARCH_BCM4760
makes the linker complain of duplicate symbols.

Shouldn't the mach-bcm subdir be included always and let then Makefile
therein sort what to build?

As I side note, I think this CONFIG_ARCH_BCM option is misnamed, shouldn't be
something like CONFIG_ARCH_BCM281XX? It looks about this ARMv7 family only.

Thanks,
Domenico
