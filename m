From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Thu, 16 Oct 2014 08:09:49 +0000
Subject: [PATCH] spi/atmel: add support for runtime PM
In-Reply-To: <20141016073004.GL27755@sirena.org.uk>
References: <1413424160-21180-1-git-send-email-wenyou.yang@atmel.com>
 <20141016073004.GL27755@sirena.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A243641BF589DDC@penmbx02.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Thursday, October 16, 2014 3:30 PM
> To: Yang, Wenyou
> Cc: linux-spi at vger.kernel.org; linux-kernel at vger.kernel.org; Ferre, Nicolas; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] spi/atmel: add support for runtime PM
> 
> On Thu, Oct 16, 2014 at 09:49:20AM +0800, Wenyou Yang wrote:
> 
> > +static int atmel_spi_runtime_resume(struct device *dev) {
> > +	struct spi_master *master = dev_get_drvdata(dev);
> > +	struct atmel_spi *as = spi_master_get_devdata(master);
> > +
> > +	pinctrl_pm_select_default_state(dev);
> > +	clk_prepare_enable(as->clk);
> > +
> 
> This looks mostly good but you should check the return value of
> clk_prepare_enable() - it can fail.
Thanks a lot, I will add it.

Best Regards,
Wenyou Yang
