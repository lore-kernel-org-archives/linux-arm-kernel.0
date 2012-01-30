From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 30 Jan 2012 12:01:14 -0700
Subject: [PATCH 6/6] mmc: sdhci-s3c: Add device tree support
In-Reply-To: <201201301051.22396.heiko@sntech.de>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
 <1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
 <201201301051.22396.heiko@sntech.de>
Message-ID: <20120130190114.GR28397@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 10:51:11AM +0100, Heiko St?bner wrote:
> Am Mittwoch, 2. November 2011, 21:36:03 schrieb Thomas Abraham:
> 
> Hi Thomas,
> 
> in patch 1/6:
> > +static struct platform_device_id sdhci_s3c_driver_ids[] = {
> > +       {
> > +               .name           = "s3c-sdhci",
> > +               .driver_data    = (kernel_ulong_t)NULL,
> > +       },
> > +       {
> > +               .name           = "exynos4-sdhci",
> > +               .driver_data    = EXYNOS4_SDHCI_DRV_DATA,
> > +       },
> > +};
> > +MODULE_DEVICE_TABLE(platform, sdhci_s3c_driver_ids);
> 
> 
> and in patch 6/6:
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id sdhci_s3c_dt_match[] = {
> > +	{ .compatible = "samsung,s3c6410-sdhci", },
> > +	{ .compatible = "samsung,exynos4210-sdhci",
> > +		.data = &exynos4_sdhci_drv_data },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
> 
> wouldn't it be better to keep the naming consistent between of and non-of?
> I.e. s3c-sdhci vs. s3c6410-sdhci. Since the driver is used for all S3C SoCs 
> containing hsmmc controllers I think s3c-sdhci would be preferable here.

History has shown that future devices aren't always compatible with earlier
ones.  Compatible strings are expected to be specific to an exact device to
reduce the possibility of new hardware breaking assumptions.

Instead, new hardware can either claim compatibility with older
compatible strings (the compatible property in the DT is a list), or
can have the new string added to the match table in the driver;
whichever option makes the most sense.

g.
