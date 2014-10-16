From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 16 Oct 2014 14:41:14 +0200
Subject: [PATCH v2 7/7] mfd: ab8500: Decrement the power supply's device
 reference counter
In-Reply-To: <20141016122901.GA22725@lee--X1>
References: <1413445327-24862-1-git-send-email-k.kozlowski@samsung.com>
 <1413445327-24862-8-git-send-email-k.kozlowski@samsung.com>
 <20141016122901.GA22725@lee--X1>
Message-ID: <1413463274.18828.1.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On czw, 2014-10-16 at 14:29 +0200, Lee Jones wrote:
> On Thu, 16 Oct 2014, Krzysztof Kozlowski wrote:
> 
> > Use power_supply_put() to decrement the power supply's device reference
> > counter.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> I already Acked this.

I think you acked mfd change in my first patchset
(power_supply_get_property()):
	[PATCH 5/8] mfd: ab8500: Use power_supply_*() API for accessing
function attrs

... and this is my second patchset with other API (power_supply_put).

Best regards,
Krzysztof


> 
> > ---
> >  drivers/mfd/ab8500-sysctrl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
> > index 93b2d2c32ca3..d05a5719cfc4 100644
> > --- a/drivers/mfd/ab8500-sysctrl.c
> > +++ b/drivers/mfd/ab8500-sysctrl.c
> > @@ -51,6 +51,7 @@ static void ab8500_power_off(void)
> >  
> >  		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
> >  				&val);
> > +		power_supply_put(psy);
> >  
> >  		if (!ret && val.intval) {
> >  			charger_present = true;
> > @@ -73,6 +74,7 @@ static void ab8500_power_off(void)
> >  			       pss[i]);
> >  			machine_restart("charging");
> >  		}
> > +		power_supply_put(psy);
> >  	}
> >  
> >  shutdown:
> 
