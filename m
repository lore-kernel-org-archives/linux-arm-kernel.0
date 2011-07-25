From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2011 10:40:02 +0100
Subject: [PATCH V4 12/14] spi/s3c64xx: Add support DMA engine API
In-Reply-To: <1311557312-26107-13-git-send-email-boojin.kim@samsung.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-13-git-send-email-boojin.kim@samsung.com>
Message-ID: <20110725094002.GD9653@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 10:28:30AM +0900, Boojin Kim wrote:
> +static void s3c64xx_spi_dma_rxcb(void *data)
> +{
> +	struct s3c64xx_spi_driver_data *sdd
> +		= (struct s3c64xx_spi_driver_data *)data;

You never need explicit casts from void * or to void *.  Please remove
these.
