From: joe@perches.com (Joe Perches)
Date: Wed, 28 Oct 2015 11:53:06 -0700
Subject: [PATCH 2/3] iio: light: lm3533-als: Print error message on
 invalid resistance
In-Reply-To: <20151028183750.GB24668@usrtlx11787.corpusers.net>
References: <1445796586-28683-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1445796586-28683-2-git-send-email-bjorn.andersson@sonymobile.com>
 <1445973507.2757.40.camel@perches.com>
 <20151028183750.GB24668@usrtlx11787.corpusers.net>
Message-ID: <1446058386.2757.145.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-10-28 at 11:37 -0700, Bjorn Andersson wrote:
> On Tue 27 Oct 12:18 PDT 2015, Joe Perches wrote:
> > On Sun, 2015-10-25 at 11:09 -0700, Bjorn Andersson wrote:
> > > Print an error message to indicate that invalid configuration data was
> > > provided in the platform_data, rather than just aborting initialization.
> > Perhaps it'd be nicer to show the 3 values.
> I do agree that it would be helpful to hint the developer about the
> expected range. The problem I see here though is that, in the case of
> devicetree we've now moved from resistance to a register value.
[]
> So would you be okay with not improving the message? Or would you like
> me to just move it into the code in patch 1 - and leave the
> platform_data case as it was (with a silent failure)?
[]
> > > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> > []
> > > @@ -743,8 +743,10 @@ static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
> > >  {
> > >  	int ret;
> > >  
> > > -	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX)
> > > +	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
> > > +		dev_err(&als->pdev->dev, "invalid resistor value\n");
> > >  		return -EINVAL;
> > > +	};
> > >  

What I suggested was just a trivial proposal.
Whatever you do is fine with me.
