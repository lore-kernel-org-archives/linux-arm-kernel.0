From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 3 Jan 2017 11:59:32 +0100
Subject: [PATCH v1] mtd: nand: tango: Reset pbus to raw mode in probe
In-Reply-To: <e73bf318-c715-af8c-3fdc-3c5c93a13472@sigmadesigns.com>
References: <e73bf318-c715-af8c-3fdc-3c5c93a13472@sigmadesigns.com>
Message-ID: <20170103115932.010c6efb@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Jan 2017 11:01:14 +0100
Marc Gonzalez <marc_gonzalez@sigmadesigns.com> wrote:

> Linux should not expect the boot loader to properly configure the
> peripheral bus "pad mode", so reset PBUS_PAD_MODE to raw.
> 

Applied to nand/fixes.

Thanks,

Boris

> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  drivers/mtd/nand/tango_nand.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/nand/tango_nand.c b/drivers/mtd/nand/tango_nand.c
> index d370c0382808..2456640fe4d5 100644
> --- a/drivers/mtd/nand/tango_nand.c
> +++ b/drivers/mtd/nand/tango_nand.c
> @@ -644,6 +644,8 @@ static int tango_nand_probe(struct platform_device *pdev)
>  	if (IS_ERR(nfc->pbus_base))
>  		return PTR_ERR(nfc->pbus_base);
>  
> +	writel_relaxed(MODE_RAW, nfc->pbus_base + PBUS_PAD_MODE);
> +
>  	clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
> 
