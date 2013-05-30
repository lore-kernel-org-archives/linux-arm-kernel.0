From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 30 May 2013 12:06:11 +0800
Subject: [RFC 1/3] SPI: imx: Convert to devm_* API
In-Reply-To: <1369885838.170762928@f286.mail.ru>
References: <20130529144909.GT3660@sirena.org.uk>
 <1369847430-10799-1-git-send-email-shc_work@mail.ru>
 <20130530020524.GB1875@S2101-09.ap.freescale.net>
 <1369885838.170762928@f286.mail.ru>
Message-ID: <20130530040609.GA2161@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 07:50:38AM +0400, Alexander Shiyan wrote:
> > On Wed, May 29, 2013 at 09:10:28PM +0400, Alexander Shiyan wrote:
> > > Use devm_* functions for the driver.
> > > This ensures more consistent error values and simplifies error paths.
> > > 
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > >  drivers/spi/spi-imx.c | 79 ++++++++++++++-------------------------------------
> > >  1 file changed, 21 insertions(+), 58 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> ...
> > >  	master->dev.of_node = pdev->dev.of_node;
> > >  	ret = spi_bitbang_start(&spi_imx->bitbang);
> > 
> > ---8<-----
> > > -	if (ret) {
> > > -		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
> > > -		goto out_clk_put;
> > > -	}
> > > -
> > > -	dev_info(&pdev->dev, "probed\n");
> > > +	if (!ret)
> > > +		return 0;
> > >  
> > > -	return ret;
> > > +	dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
> > >  
> > > -out_clk_put:
> > --->8------
> > 
> > I do not understand why above changes are necessary.
> 
> This just simplifies the error path and removes one "goto".
> 
Sorry, I do not get it and take this as a diff stat churn.

Shawn
