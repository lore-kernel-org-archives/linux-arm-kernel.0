From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Sep 2013 16:29:19 -0700
Subject: [PATCH] ARM: mach-omap2: gpmc: Fix warning when CONFIG_ARM_LPAE=y
In-Reply-To: <87y57tx6g6.fsf@linaro.org>
References: <1377131523-19392-1-git-send-email-festevam@gmail.com>
 <87y57tx6g6.fsf@linaro.org>
Message-ID: <20130917232918.GM9994@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@linaro.org> [130822 05:27]:
> Fabio Estevam <festevam@gmail.com> writes:
> 
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > When CONFIG_ARM_LPAE=y the following build warning is generated:
> >
> > arch/arm/mach-omap2/gpmc.c:1495:4: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' [-Wformat]
> >
> > According to Documentation/printk-formats.txt '%pa' can be used to properly
> > print 'resource_size_t'.
> >
> > Reported-by: Kevin Hilman <khilman@linaro.org>
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

Thanks applying into omap-for-v3.12/fixes.

Tony
 
> > ---
> >  arch/arm/mach-omap2/gpmc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> > index f3fdd6a..ad6da1d 100644
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -1491,8 +1491,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
> >  	 */
> >  	ret = gpmc_cs_remap(cs, res.start);
> >  	if (ret < 0) {
> > -		dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%x\n",
> > -			cs, res.start);
> > +		dev_err(&pdev->dev, "cannot remap GPMC CS %d to %pa\n",
> > +			cs, &res.start);
> >  		goto err;
> >  	}
