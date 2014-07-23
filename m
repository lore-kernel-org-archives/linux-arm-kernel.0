From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Jul 2014 16:05:18 +0100
Subject: [PATCH] drivers: CCI: Correct use of ! and &
In-Reply-To: <9hhwqb42k63.fsf@arm.com>
References: <20140707140538.GA4204@himangi-Dell>
 <9hhwqb42k63.fsf@arm.com>
Message-ID: <20140723150518.GD27677@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 04:01:56PM +0100, Punit Agrawal wrote:
> > diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> > index 5a86da9..7af78df 100644
> > --- a/drivers/bus/arm-cci.c
> > +++ b/drivers/bus/arm-cci.c
> > @@ -397,7 +397,8 @@ static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
> >  		hw_counter = &event->hw;
> >  
> >  		/* Did this counter overflow? */
> > -		if (!pmu_read_register(idx, CCI_PMU_OVRFLW) & CCI_PMU_OVRFLW_FLAG)
> > +		if (!(pmu_read_register(idx, CCI_PMU_OVRFLW) &
> > +		      CCI_PMU_OVRFLW_FLAG))
> >  			continue;
> 
> 
> Going back to the manual, this fix looks correct.
> 
> Acked-by: Punit Agrawal <punit.agrawal@arm.com>
> 
> Will, would this go via your tree?

Given that you're happy with it, I don't mind which tree it goes in.
Probably deserves a CC stable on it too.

If you get stuck, put it in rmk's patch system.

Will
