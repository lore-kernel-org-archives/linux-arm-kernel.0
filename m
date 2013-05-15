From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 15 May 2013 23:48:31 +0200
Subject: [RFC 2/4] dma: add dmaengine driver for Samsung s3c24xx SoCs
In-Reply-To: <5193FC08.5040002@gmail.com>
References: <201305111330.05046.heiko@sntech.de>
 <201305152231.52423.heiko@sntech.de> <5193FC08.5040002@gmail.com>
Message-ID: <201305152348.32171.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. Mai 2013, 23:20:08 schrieb Sylwester Nawrocki:
> On 05/15/2013 10:31 PM, Heiko St?bner wrote:
> >>> +       BUG();
> >>> 
> >> >  Isn't that a bit nasty. This macro should be used with care and we
> >> >  should recover if possible. dev_err()?
> > 
> > runtime_config already denies any settings not in the 1,2 or 4bytes range
> > - the default-part should therefore never be reached. So if any other
> > value magically appears in the register and triggers the default-part,
> > something is seriously wrong. So my guess is, the BUG might be
> > appropriate.
> > 
> > On the other hand the whole default+BUG part could also simply go away,
> > for the same reasons.
> 
> IMHO BUG() is not needed at all. As Linus suggested dev_err() is such case
> or WARN_ON() would be more appropriate. This has been discussed in the past
> extensively, not sure if you are aware of the other Linus' opinion on
> BUG()/BUG_ON() proliferation: https://lkml.org/lkml/2012/9/27/461

Very interesting read and I'll keep this in mind in the future. What about the 
other option ... i.e. simply getting rid of the whole "error handling", as the 
other code paths should already make sure that only valid values get written 
into the register.

Can the value change in the register somehow on its own without kernel 
intervention, or does this not happen?


Thanks
Heiko
