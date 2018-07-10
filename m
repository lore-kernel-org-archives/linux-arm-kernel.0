From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Jul 2018 19:15:59 +0100
Subject: [PATCH v10 5/6] spi: at91-usart: add driver for at91-usart as spi
In-Reply-To: <20180625172230.29686-6-radu.pirea@microchip.com>
References: <20180625172230.29686-1-radu.pirea@microchip.com>
 <20180625172230.29686-6-radu.pirea@microchip.com>
Message-ID: <20180710181559.GG8104@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2018 at 08:22:29PM +0300, Radu Pirea wrote:

This is mostly good, just a couple of small things:

> +config SPI_AT91_USART
> +	tristate "Atmel USART Controller SPI driver"
> +	depends on HAS_DMA
> +	depends on (ARCH_AT91 || COMPILE_TEST)
> +	select MFD_AT91_USART

Why is this selecting rather than depending on the MFD like we normally
do?

> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for AT91 USART Controllers as SPI
> + *
> + * Copyright (C) 2018 Microchip Technology Inc.
> + * Author: Radu Pirea <radu.pirea@microchip.com>
> + */

Please use C++ comments for the whole block so it looks a bit more
intentional.

Otherwise 

Reviwed-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/8d6520d9/attachment.sig>
