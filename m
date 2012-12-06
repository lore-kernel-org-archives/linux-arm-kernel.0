From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 06 Dec 2012 14:05:15 +0000
Subject: [PATCH 1/4] spi: sh-msiof: Remove unneeded clock name
In-Reply-To: <1352288407-20594-2-git-send-email-hechtb@gmail.com>
References: <1352288407-20594-1-git-send-email-hechtb@gmail.com>
 <1352288407-20594-2-git-send-email-hechtb@gmail.com>
Message-ID: <20121206140515.75E6B3E089D@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  7 Nov 2012 12:40:04 +0100, Bastian Hecht <hechtb@gmail.com> wrote:
> clk_get() no longer needs a character string for associating the right
> clock as this is done via the device struct now.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-sh-msiof.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 1f466bc..96358d0 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -597,7 +597,6 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
>  	struct resource	*r;
>  	struct spi_master *master;
>  	struct sh_msiof_spi_priv *p;
> -	char clk_name[16];
>  	int i;
>  	int ret;
>  
> @@ -614,10 +613,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
>  	p->info = pdev->dev.platform_data;
>  	init_completion(&p->done);
>  
> -	snprintf(clk_name, sizeof(clk_name), "msiof%d", pdev->id);
> -	p->clk = clk_get(&pdev->dev, clk_name);
> +	p->clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(p->clk)) {
> -		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
> +		dev_err(&pdev->dev, "cannot get clock\n");
>  		ret = PTR_ERR(p->clk);
>  		goto err1;
>  	}
> -- 
> 1.7.5.4
> 
> 
> ------------------------------------------------------------------------------
> LogMeIn Central: Instant, anywhere, Remote PC access and management.
> Stay in control, update software, and manage PCs from one command center
> Diagnose problems and improve visibility into emerging IT issues
> Automate, monitor and manage. Do more in less time with Central
> http://p.sf.net/sfu/logmein12331_d2d
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general at lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
