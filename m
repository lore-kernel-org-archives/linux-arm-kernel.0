From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 1 Feb 2012 17:11:07 -0700
Subject: [PATCH] spi/nuc900: Remove unnecessary memset of struct nuc900_spi
In-Reply-To: <1328099622-14058-1-git-send-email-tklauser@distanz.ch>
References: <1328099622-14058-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20120202001107.GC15343@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 01:33:42PM +0100, Tobias Klauser wrote:
> The memory allocated using kzalloc by spi_alloc_master so it doesn't
> need to be set to 0 again.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Merged, thanks.

g.

> ---
>  drivers/spi/spi-nuc900.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
> index 182e9c8..dae8be2 100644
> --- a/drivers/spi/spi-nuc900.c
> +++ b/drivers/spi/spi-nuc900.c
> @@ -360,8 +360,6 @@ static int __devinit nuc900_spi_probe(struct platform_device *pdev)
>  	}
>  
>  	hw = spi_master_get_devdata(master);
> -	memset(hw, 0, sizeof(struct nuc900_spi));
> -
>  	hw->master = spi_master_get(master);
>  	hw->pdata  = pdev->dev.platform_data;
>  	hw->dev = &pdev->dev;
> -- 
> 1.7.5.4
> 
