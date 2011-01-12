From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 12 Jan 2011 14:17:23 +0800
Subject: [PATCH 2/2] ARM i.MXS: Add auart platform support for i.MX28
In-Reply-To: <1294758545-9445-3-git-send-email-s.hauer@pengutronix.de>
References: <1294758545-9445-1-git-send-email-s.hauer@pengutronix.de>
	<1294758545-9445-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110112061722.GF2888@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Jan 11, 2011 at 04:09:05PM +0100, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mxs/clock-mx28.c                  |    5 ++
>  arch/arm/mach-mxs/devices-mx28.h                |    8 +++
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-auart.c      |   54 +++++++++++++++++++++++
>  arch/arm/mach-mxs/include/mach/devices-common.h |   10 ++++
>  6 files changed, 81 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-auart.c
> 
[...]
> +struct platform_device *__init mxs_add_auart(
> +		const struct mxs_auart_data *data)
> +{
> +	struct resource res[] = {
> +		{
> +			.start = data->iobase,
> +			.end = data->iobase + SZ_4K - 1,
The io size here is supposed to mean the space for holding the
current defined registers or the memory map size for this block
given by SoC design?  If it's the latter, the size should be SZ_8K.

> +			.flags = IORESOURCE_MEM,
> +		}, {
> +			.start = data->irq,
> +			.end = data->irq,
> +			.flags = IORESOURCE_IRQ,
> +		},
> +	};
> +
> +	return mxs_add_platform_device_dmamask("mxs-auart", data->id,
> +					res, ARRAY_SIZE(res), NULL, 0,
> +					DMA_BIT_MASK(32));
> +}
> +

-- 
Regards,
Shawn
