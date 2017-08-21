From: stwiss.opensource@diasemi.com (Steve Twiss)
Date: Mon, 21 Aug 2017 12:32:32 +0000
Subject: [PATCH 1/1] Revert "mfd: da9061: Fix to remove BBAT_CONT
 register from chip model"
In-Reply-To: <20170821074936.ae2sw2ncvoaxsq3w@dell>
References: <20170815083804.26073-1-lee.jones@linaro.org>
 <20170821074936.ae2sw2ncvoaxsq3w@dell>
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7019411968F@SW-EX-MBX02.diasemi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 August 2017 08:50, Lee Jones wrote:

Hi Lee,

> To: Steve Twiss
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 1/1] Revert "mfd: da9061: Fix to remove BBAT_CONT register from chip model"
> 
> On Tue, 15 Aug 2017, Lee Jones wrote:
> 
> > This patch was applied to the MFD twice, causing unwanted behavour.
> >
> > This reverts commit b77eb79acca3203883e8d8dbc7f2b842def1bff8.
> >
> > Fixes: b77eb79acca3 ("mfd: da9061: Fix to remove BBAT_CONT register from chip model")
> > Reported-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/da9062-core.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Steve, It would be good to obtain a {Reviewed|Acked}-by from you
> before applying.
>

Sure.

> > diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
> > index fbe0f245ce8e..fe1811523e4a 100644
> > --- a/drivers/mfd/da9062-core.c
> > +++ b/drivers/mfd/da9062-core.c
> > @@ -645,6 +645,9 @@ static const struct regmap_range da9062_aa_readable_ranges[] = {
> >  		.range_min = DA9062AA_VLDO1_B,
> >  		.range_max = DA9062AA_VLDO4_B,
> >  	}, {
> > +		.range_min = DA9062AA_BBAT_CONT,
> > +		.range_max = DA9062AA_BBAT_CONT,
> > +	}, {
> >  		.range_min = DA9062AA_INTERFACE,
> >  		.range_max = DA9062AA_CONFIG_E,
> >  	}, {
> > @@ -721,6 +724,9 @@ static const struct regmap_range da9062_aa_writeable_ranges[] = {
> >  		.range_min = DA9062AA_VLDO1_B,
> >  		.range_max = DA9062AA_VLDO4_B,
> >  	}, {
> > +		.range_min = DA9062AA_BBAT_CONT,
> > +		.range_max = DA9062AA_BBAT_CONT,
> > +	}, {
> >  		.range_min = DA9062AA_GP_ID_0,
> >  		.range_max = DA9062AA_GP_ID_19,
> >  	},

This looks good. Thanks for the changes.

Reviewed-by: Steve Twiss <stwiss.opensource@diasemi.com>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
