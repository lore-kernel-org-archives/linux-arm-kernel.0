From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 13:34:17 +0100
Subject: [PATCH 1/6 v8] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <20101219174017.GA31832@alchark-u3s>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<20101107165745.GB1759@n2100.arm.linux.org.uk>
	<AANLkTimFJ=Brx4pDiUqZOKDfABaDg0s_yFC7EkZGi7D8@mail.gmail.com>
	<20101107171726.GF1759@n2100.arm.linux.org.uk>
	<20101108171930.GA1471@alchark-u3s.lan>
	<20101111212322.GA15533@alchark-u3s.lan>
	<20101111234957.GA28735@n2100.arm.linux.org.uk>
	<20101219174017.GA31832@alchark-u3s>
Message-ID: <20110706123417.GA25400@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 19, 2010 at 08:40:17PM +0300, Alexey Charkov wrote:
> +static struct map_desc vt8500_io_desc[] __initdata = {
> +	/* SoC MMIO registers, to be filled in later */
> +	[0] = {
> +		.type		= MT_DEVICE
> +	},
> +	/* PCI I/O space, numbers tied to those in <mach/io.h> */
> +	[1] = {
> +		.virtual	= 0xf0000000,
> +		.pfn		= __phys_to_pfn(0xc0000000),
> +		.length		= SZ_64K,
> +		.type		= MT_DEVICE
> +	},
> +};
...
> diff --git a/arch/arm/mach-vt8500/include/mach/io.h b/arch/arm/mach-vt8500/include/mach/io.h
> new file mode 100644
> index 0000000..8dd55c8
> --- /dev/null
> +++ b/arch/arm/mach-vt8500/include/mach/io.h
> +#ifndef __ASM_ARM_ARCH_IO_H
> +#define __ASM_ARM_ARCH_IO_H
> +
> +#define IO_SPACE_LIMIT 0xffff
> +
> +#define __io(a)		((void __iomem *)((a) + 0xf0000000))
> +#define __mem_pci(a)	(a)

Can you explain why you seem to have PCI IO space, yet don't have CONFIG_PCI
selected?  Do you have any drivers which use this space without CONFIG_PCI=y?

Thanks.
