From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 15 May 2017 22:47:51 +0200
Subject: [PATCH] mtd: nand: tango: Export OF device ID table as module
 aliases
In-Reply-To: <20170501203015.7275-1-andresgalacho@gmail.com>
References: <20170501203015.7275-1-andresgalacho@gmail.com>
Message-ID: <20170515224751.60d34a50@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  1 May 2017 16:30:15 -0400
Andres Galacho <andresgalacho@gmail.com> wrote:

> The device table is required to load modules based on
> modaliases. After adding MODULE_DEVICE_TABLE, below entries
> for example will be added to module.alias:
> alias:          of:N*T*Csigma,smp8758-nandC*
> alias:          of:N*T*Csigma,smp8758-nand
> 
> Signed-off-by: Andres Galacho <andresgalacho@gmail.com>

Applied to nand/fixes.

Thanks,

Boris

> ---
>  drivers/mtd/nand/tango_nand.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/tango_nand.c b/drivers/mtd/nand/tango_nand.c
> index 05b6e1065203..82fea9b4c358 100644
> --- a/drivers/mtd/nand/tango_nand.c
> +++ b/drivers/mtd/nand/tango_nand.c
> @@ -663,6 +663,7 @@ static const struct of_device_id tango_nand_ids[] = {
>  	{ .compatible = "sigma,smp8758-nand" },
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, tango_nand_ids);
>  
>  static struct platform_driver tango_nand_driver = {
>  	.probe	= tango_nand_probe,
