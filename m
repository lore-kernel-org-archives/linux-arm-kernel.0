From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 13 Jul 2011 10:59:53 -0700
Subject: [PATCH] i2c: tegra: Use engineering names in DT compatible
	property
In-Reply-To: <20110706053941.GE9978@ponder.secretlab.ca>
References: <1309897306-22953-1-git-send-email-swarren@nvidia.com>
	<20110706053941.GE9978@ponder.secretlab.ca>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049E834757@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote at Tuesday, July 05, 2011 11:40 PM:
> On Tue, Jul 05, 2011 at 02:21:46PM -0600, Stephen Warren wrote:
> > Engineering names are more stable than marketing names. Hence, use them
> > for Device Tree compatible properties instead.
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > Grant, this is against devicetree/arm and also makes sense for
> > devicetree/test.
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Ben is the one to pick up this patch.

I don't believe anyone ever sent a patch to Ben to add tegra_i2c_of_match
to the driver; the OF support patch didn't include that part of the code.
As such, Ben can't yet apply this to his tree. (Although I note this patch
is in Grant's /arm and /test trees, which is probably good enough for now).

> >  drivers/i2c/busses/i2c-tegra.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> > index 8914bd1..99b1b6d 100644
> > --- a/drivers/i2c/busses/i2c-tegra.c
> > +++ b/drivers/i2c/busses/i2c-tegra.c
> > @@ -716,7 +716,7 @@ static int tegra_i2c_resume(struct platform_device *pdev)
> >  #if defined(CONFIG_OF)
> >  /* Match table for of_platform binding */
> >  static const struct of_device_id tegra_i2c_of_match[] __devinitconst = {
> > -	{ .compatible = "nvidia,tegra250-i2c", },
> > +	{ .compatible = "nvidia,tegra20-i2c", },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, tegra_i2c_of_match);
> > --
> > 1.7.0.4
> >

-- 
nvpublic
