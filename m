From: attila@kinali.ch (Attila Kinali)
Date: Mon, 16 Jul 2012 09:57:41 +0200
Subject: [PATCH 04/10 RESEND] mmc: spi: Pull out parts shared between
 MMC and SPI
In-Reply-To: <1341555449-17507-4-git-send-email-marex@denx.de>
References: <1341555449-17507-1-git-send-email-marex@denx.de>
 <1341555449-17507-4-git-send-email-marex@denx.de>
Message-ID: <20120716095741.85d959fc81ab759b10adcf25@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moin,

I just wanted to try out this patchset as i have a use for proper spi
support on i.mx23. But this patch (4/10) fails to apply at line 635

On Fri,  6 Jul 2012 08:17:23 +0200
Marek Vasut <marex@denx.de> wrote:

> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index f9509e8..1ea1cba 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -635,6 +640,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  	dma_cap_mask_t mask;
>  	struct regulator *reg_vmmc;
>  	enum of_gpio_flags flags;
> +	struct mxs_ssp *ssp;
>  
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);

The function variables do not match.

Also a 3way merge didnt work as the comit on which this patchset was
based on wasnt found. I tried linux, linux-next, and the imx repos
from pengutronix and Shawn, to no avail.

Is there any other repo around that i'm not aware of?

			Attila Kinali

-- 
The trouble with you, Shev, is you don't say anything until you've saved
up a whole truckload of damned heavy brick arguments and then you dump
them all out and never look at the bleeding body mangled beneath the heap
		-- Tirin, The Dispossessed, U. Le Guin
