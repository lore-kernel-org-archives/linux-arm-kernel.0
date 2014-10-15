From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 15 Oct 2014 14:19:29 +0200
Subject: [PATCH 2/8] power_supply: sysfs: Use power_supply_*() API for
 accessing function attrs
In-Reply-To: <1413370199.26771.4.camel@AMDC1943>
References: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
 <1413289246-31650-3-git-send-email-k.kozlowski@samsung.com>
 <20141015103217.GB14266@amd> <1413370199.26771.4.camel@AMDC1943>
Message-ID: <20141015121929.GB26579@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > @@ -76,7 +76,7 @@ static ssize_t power_supply_show_property(struct device *dev,
> > >  	if (off == POWER_SUPPLY_PROP_TYPE) {
> > >  		value.intval = psy->type;
> > >  	} else {
> > > -		ret = psy->get_property(psy, off, &value);
> > > +		ret = power_supply_get_property(psy, off, &value);
> > >  
> > 
> > One thing.. Your power_supply_get_property (and friends) check for psy
> > == NULL. Is it neccessary / good idea? As far as I can tell, it should
> > not really be NULL...
> 
> It is not necessary. I thought it would be a good behavior of such
> exported function. You're right that this shouldn't be NULL especially
> because previously it was dereferenced.
> 
> Other existing power supply exported functions don't check this so maybe
> I shouldn't introduce inconsistency.
> 
> I'll remove the check and re-spin. I'll found ugly typos in commit
> message anyway.

Thanks!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
