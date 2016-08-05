From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 4 Aug 2016 17:58:26 -0700
Subject: [PATCH 1/3] regulator: qcom_smd: Fix voltage ranges for pm8x41
In-Reply-To: <20160711224845.GC6053@hector.attlocal.net>
References: <20160711215009.4519-1-sboyd@codeaurora.org>
 <20160711215009.4519-2-sboyd@codeaurora.org>
 <20160711224845.GC6053@hector.attlocal.net>
Message-ID: <20160805005826.GD15690@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11, Andy Gross wrote:
> On Mon, Jul 11, 2016 at 02:50:07PM -0700, Stephen Boyd wrote:
> 
> >  static const struct regulator_desc pm8941_pldo = {
> >  	.linear_ranges = (struct regulator_linear_range[]) {
> > -		REGULATOR_LINEAR_RANGE( 750000,  0,  30, 25000),
> > -		REGULATOR_LINEAR_RANGE(1500000, 31, 99, 50000),
> > +		REGULATOR_LINEAR_RANGE( 750000,  0,  63, 12500),
> > +		REGULATOR_LINEAR_RANGE(1550000, 64, 126, 25000),
> > +		REGULATOR_LINEAR_RANGE(3100000, 127, 163, 50000),
> >  	},
> > -	.n_linear_ranges = 2,
> > -	.n_voltages = 100,
> > +	.n_linear_ranges = 3,
> > +	.n_voltages = 164,
> >  	.ops = &rpm_smps_ldo_ops,
> >  };
> 
> Still a little confused on if the 12.5mV is allowed on pmos ldo.  It seems like the
> nmos has 1 range of 5mV steps.  The PMOS has 2 ranges, using 25mV and 50mV
> 

The values I've put in these patches are the correct ranges.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
