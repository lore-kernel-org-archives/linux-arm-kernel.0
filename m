From: henryc.chen@mediatek.com (Henry Chen)
Date: Fri, 13 May 2016 16:04:20 +0800
Subject: [PATCH RESEND 2/2] regulator: mt6397: Add buck change mode
 regulator interface for mt6397
In-Reply-To: <20160511145046.GI6261@sirena.org.uk>
References: <1462959090-2877-1-git-send-email-henryc.chen@mediatek.com>
 <1462959090-2877-3-git-send-email-henryc.chen@mediatek.com>
 <20160511145046.GI6261@sirena.org.uk>
Message-ID: <1463126660.2821.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, 2016-05-11 at 15:50 +0100, Mark Brown wrote:
> On Wed, May 11, 2016 at 05:31:30PM +0800, Henry Chen wrote:
> 
> > +The possible values for "regulator-supported-modes" are:
> > +	0: PWM mode, mapping to regulator fast mode, allow the
> > +	converter to remain in the PWM mode regardless of the load current, so
> > +	that the noise spectrum of the converter can be minimized for certain
> > +	highly-noise-sensitive handset applications.
> > +	1: Auto mode, mapping to regulator normal mode, mode switch by current
> > +	loading. At light load currents, the converter automatically enters
> > +	PFM mode to save power and improve light load efficiency. At heavy
> > +	load currents, the converter automatically enters PWM mode to minimiz
> > +	the noise spectrum of the converter.
> 
> The details of how this maps onto Linux shouldn't be in the bindings.
> 
> > +				regulator-allow-change-mode;
> > +				regulator-supported-modes = <0 1>;
> 
> These are problematic too as covered in my other mail. 
> 
> > -static struct regulator_ops mt6397_volt_range_ops = {
> > +static const struct regulator_ops mt6397_volt_range_ops = {
> 
> The constification is fine but an unrelated change.  Otherwise this
> looks fine from a code point of view, let's get that merged separately.

Okay, although we didn't have conclusion and solution for regulator
operation mode, as you said that we can get some patch merged
separately, so I will resend the patch which clean up comments from
you and Daniel.
