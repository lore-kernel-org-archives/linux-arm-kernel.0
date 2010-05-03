From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 3 May 2010 02:18:44 +0200
Subject: [spi-devel-general] [PATCH v6 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
In-Reply-To: <0dce0e9fdb6af35854d26d7bd0d8af5a5ea8f76a.1272805161.git.mika.westerberg@iki.fi>
References: <cover.1272805161.git.mika.westerberg@iki.fi>
	<0dce0e9fdb6af35854d26d7bd0d8af5a5ea8f76a.1272805161.git.mika.westerberg@iki.fi>
Message-ID: <h2r63386a3d1005021718k31125e4fz43a08025997b5c5c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/2 Mika Westerberg <mika.westerberg@iki.fi>:

> This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
> in EP93xx chips.
(...)
> +#define SSPCR0 ? ? ? ? ? ? ? ? 0x0000
> +#define SSPCR0_MODE_SHIFT ? ? ?6
> +#define SSPCR0_SCR_SHIFT ? ? ? 8
> +
> +#define SSPCR1 ? ? ? ? ? ? ? ? 0x0004
> +#define SSPCR1_RIE ? ? ? ? ? ? BIT(0)
> +#define SSPCR1_TIE ? ? ? ? ? ? BIT(1)
> +#define SSPCR1_RORIE ? ? ? ? ? BIT(2)
> +#define SSPCR1_LBM ? ? ? ? ? ? BIT(3)
> +#define SSPCR1_SSE ? ? ? ? ? ? BIT(4)
> +#define SSPCR1_MS ? ? ? ? ? ? ?BIT(5)
> +#define SSPCR1_SOD ? ? ? ? ? ? BIT(6)
> +
> +#define SSPDR ? ? ? ? ? ? ? ? ?0x0008
> +
> +#define SSPSR ? ? ? ? ? ? ? ? ?0x000c
> +#define SSPSR_TFE ? ? ? ? ? ? ?BIT(0)
> +#define SSPSR_TNF ? ? ? ? ? ? ?BIT(1)
> +#define SSPSR_RNE ? ? ? ? ? ? ?BIT(2)
> +#define SSPSR_RFF ? ? ? ? ? ? ?BIT(3)
> +#define SSPSR_BSY ? ? ? ? ? ? ?BIT(4)
> +#define SSPCPSR ? ? ? ? ? ? ? ? ? ? ? ?0x0010
> +
> +#define SSPIIR ? ? ? ? ? ? ? ? 0x0014
> +#define SSPIIR_RIS ? ? ? ? ? ? BIT(0)
> +#define SSPIIR_TIS ? ? ? ? ? ? BIT(1)
> +#define SSPIIR_RORIS ? ? ? ? ? BIT(2)
> +#define SSPICR ? ? ? ? ? ? ? ? SSPIIR

When I look at this it's quite obvious that this is the same hardware or very
close (maybe a redux version) of the thing supported by
drivers/spi/amba-pl022.c.

What is the difference really? I suspect this is a PL022 PrimeCell straight off.
Even the CPSR algorithm is the same, just written differently.

Can you make a hexdump of the PrimeCell ID registers at offset
base+0xffe0..0xffff and post the contents?

Yours,
Linus Walleij
