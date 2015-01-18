From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 18 Jan 2015 21:18:21 +0100
Subject: [PATCH] ti-soc-thermal: implement eocz bit to make driver useful
 on omap3
In-Reply-To: <20150105213557.GD31536@developer>
References: <20150103114632.GA21883@amd> <20150103122634.GB22356@developer>
 <20150103162241.GA26680@amd> <20150105213557.GD31536@developer>
Message-ID: <20150118201821.GA28530@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Ok, what do you suggest? AFAICT, without MODE_CONFIG, continuous ADC
> > mode is not available, so we have to force it periodically, so this
> > should be correct.
> 
> I will have a better look and let you know. for now, adding a single
> read should not hurt ( but I will double check)

Any news there?

> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > +
> > > >  	spin_lock(&bgp->lock);
> > > >  	temp = ti_bandgap_read_temp(bgp, id);
> > > >  	spin_unlock(&bgp->lock);
> > > >  
> > > > -	ret |= ti_bandgap_adc_to_mcelsius(bgp, temp, &temp);
> > > > +	ret = ti_bandgap_adc_to_mcelsius(bgp, temp, &temp);
> > > 
> > > this one should be part of your clean up patch
> > 
> > Ok, can you apply the cleanup patch and I'll prepare one on the top of
> > it?
> 
> I mean, you should resend the cleanup patch including the above '|=' removal, as you are already doing in the cleanup patch.
> 

Ok, little patch-editing can not hurt :-).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
