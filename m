From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 7 Nov 2010 17:00:05 +0000
Subject: [PATCH 1/6 v2] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <1289147348-31969-1-git-send-email-alchark@gmail.com>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
Message-ID: <20101107170005.GC1759@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A couple of other points - sorry, should've been in the last mail.

On Sun, Nov 07, 2010 at 07:28:52PM +0300, Alexey Charkov wrote:
> diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
> new file mode 100644
> index 0000000..e0c6268
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/Kconfig
> @@ -0,0 +1,65 @@
> +if ARCH_VT8500
> +
> +config VTWM_VERSION_VT8500
> +	bool
> +	default n

n is the default anyway, so specifying this is redundant.

> +void __init bv07_init(void)
> +{
> +#ifdef CONFIG_FB_VT8500
> +	void __iomem *gpio_mux_reg = ioremap(wmt_current_regs->gpio
> +					     + 0x200, 4);

ioremap() is generally regarded as a function which can fail, and therefore
needs its return value checked.  There seems to be multiple instances of
this through this patch.
