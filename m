From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 17 Jul 2018 13:43:48 +0200
Subject: [PATCH] mmc: sunxi: remove output of virtual base address
In-Reply-To: <20180717100958.12042-1-andre.przywara@arm.com>
References: <20180717100958.12042-1-andre.przywara@arm.com>
Message-ID: <20180717114348.lv2ngzrekp5zpcmk@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;5202;0c
On Tue, Jul 17, 2018 at 11:09:58AM +0100, Andre Przywara wrote:
> Recent Linux versions refuse to print actual virtual kernel addresses,
> to not give a hint about the location of the kernel in a randomized virtual
> address space. This affects the output of the sunxi MMC controller
> driver, which now produces the rather uninformative line:
> 
> [    1.482660] sunxi-mmc 1c0f000.mmc: base:0x(____ptrval____) irq:8
> 
> Since the virtual base address is not really interesting in the first
> place, let's just drop this value. We have the physical address as part
> of the DT node name, which is way more useful for debugging purposes.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 8e7f3e35ee3d..811b08d2d0f2 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1407,7 +1407,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto error_free_dma;
>  
> -	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
> +	dev_info(&pdev->dev, "irq:%u\n", host->irq);

Can't we just remove it? It doesn't look like it brings much value anyway.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/bf3362f2/attachment.sig>
