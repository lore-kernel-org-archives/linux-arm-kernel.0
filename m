From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Aug 2012 21:34:48 +0100
Subject: [PATCH 08/10 RESEND] spi: Add DMA support into SPI driver
In-Reply-To: <1343076052-27312-9-git-send-email-marex@denx.de>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
 <1343076052-27312-9-git-send-email-marex@denx.de>
Message-ID: <20120801203448.GX4483@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 10:40:50PM +0200, Marek Vasut wrote:

> +		/*
> +		 * Small blocks can be transfered via PIO.
> +		 * Measured by empiric means:
> +		 *
> +		 * dd if=/dev/mtdblock0 of=/dev/null bs=1024k count=1
> +		 *
> +		 * DMA only: 2.164808 seconds, 473.0KB/s
> +		 * Combined: 1.676276 seconds, 610.9KB/s
> +		 */

I've seen other devices end up using the FIFO length as the decision
point here which makes intuitive sense to me unless the FIFO is
extremely deep.

Not reviewed this properly yet but it looks OK from a first read
through.
