From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 24 Dec 2013 02:14:32 +0000
Subject: [PATCH v4 1/3] regulator: act8865: add PMIC act8865 driver
In-Reply-To: <20131223115746.GR30815@sirena.org.uk>
References: <1387776268-23036-1-git-send-email-wenyou.yang@atmel.com>
 <1387776328-23079-1-git-send-email-wenyou.yang@atmel.com>
 <20131223115746.GR30815@sirena.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A24364172F2EA7F@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Monday, December 23, 2013 7:58 PM
> To: Yang, Wenyou
> Cc: lgirdwood at gmail.com; linux-kernel at vger.kernel.org;
> grant.likely at linaro.org; rob.herring at calxeda.com; linux-
> doc at vger.kernel.org; vpalatin at chromium.org; Ferre, Nicolas;
> plagnioj at jcrosoft.com; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH v4 1/3] regulator: act8865: add PMIC act8865 driver
> 
> On Mon, Dec 23, 2013 at 01:25:28PM +0800, Wenyou Yang wrote:
> 
> > +static int act8865_set_suspend_voltage(struct regulator_dev *rdev,
> > +int uV) {
> > +	u32	selector;
> > +
> > +	selector = regulator_map_voltage_iterate(rdev, uV, uV);
> > +
> > +	return regulator_set_voltage_sel_regmap(rdev, selector); }
> 
> This looks wrong - it's going to set the normal voltage register that is
> set for runtime voltage changes.  The suspend operations are only for
> setting separate voltage registers, many PMICs know about system suspend
> and provide separate settings for that.  If this one doesn't then it
> shouldn't implement this operation.
I re-read the act8865 datasheet, There is NO a separate voltage registers for the suspend operation.
So I will remove this operation.

Thanks.

Best Regards,
Wenyou Yang
