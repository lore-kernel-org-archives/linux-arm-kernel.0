From: richard.genoud@gmail.com (Richard GENOUD)
Date: Wed, 3 Apr 2013 11:42:50 +0200
Subject: [PATCH v8 1/8] spi/spi-atmel: add physical base address
In-Reply-To: <1364968662-23763-1-git-send-email-wenyou.yang@atmel.com>
References: <1364968581-23700-1-git-send-email-wenyou.yang@atmel.com>
 <1364968662-23763-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20130403094247.GA26067@lnx-rg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On [mer., 03.04.2013 13:57:42], Wenyou Yang wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Needed for future use with dmaengine enabled driver.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: spi-devel-general at lists.sourceforge.net
> Cc: linux-kernel at vger.kernel.org
> [wenyou.yang at atmel.com: submit the patch]
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>  drivers/spi/spi-atmel.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 15e8459..38f8c0d 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -196,6 +196,7 @@ struct atmel_spi_caps {
>  struct atmel_spi {
>  	spinlock_t		lock;
>  
> +	phys_addr_t		phybase;
>  	void __iomem		*regs;
>  	int			irq;
>  	struct clk		*clk;
> @@ -996,6 +997,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
>  	as->regs = ioremap(regs->start, resource_size(regs));
>  	if (!as->regs)
>  		goto out_free_buffer;
> +	as->phybase = regs->start;
>  	as->irq = irq;
>  	as->clk = clk;
>  
> -- 
> 1.7.9.5
> 
Tested-by: Richard Genoud <richard.genoud@gmail.com>
