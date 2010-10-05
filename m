From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 5 Oct 2010 10:21:30 +0200
Subject: [PATCH v2] Input: Make ADS7846 independent on regulator
In-Reply-To: <4CAACA63.6090202@compulab.co.il>
References: <1280560182-7071-1-git-send-email-marek.vasut@gmail.com>
	<20100909094120.GB1988@rakim.wolfsonmicro.main>
	<4CAACA63.6090202@compulab.co.il>
Message-ID: <201010051021.30496.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 5. ??jna 2010 08:49:07 Igor Grinberg napsal(a):
>  On 09/09/10 12:41, Mark Brown wrote:
> > On Thu, Sep 09, 2010 at 10:27:17AM +0200, Marek Vasut wrote:
> >> Dne ?t 7. z??? 2010 14:53:35 Mark Brown napsal(a):
> >>> From a regulator API usage point of view a separate implementation of
> >>> the same thing was nacked - there are regulator API facilties for
> >>> hiding missing regulators from drivers when needed to get systems
> >>> going, unless the device genuinely can cope without supplies it should
> >>> be relying on those.
> 
> I actually, don't see why ads7846 is strictly relying on the regulator
> and I don't understand, why ads7846 driver has to bail out if the regulator
> is not found? Why shouldn't the driver try to continue?
> I think it should bail out only in case communicating with the device
> failed.

Well, I can't but agree ... it's unnecessary crud indeed.
> 
> >> Maybe these platforms should have been fixed prior to applying the patch
> >> adding regulator goo into ads7846 driver then. What's the way to go now
> >> then ?
> > 
> > Fix the platforms and use the dummy regulators to keep them going until
> > that happens.  It's trivial to do the hookup in the platforms.
> 
> You want each platform, that does not have a special regulated power supply
> for the ads7846, to define a dummy regulator just to cope with that
> artificial dependency of the device driver?

You can enable some option in the regulator stuff that automagically shoves in a 
dummy regulator, but it's still additional crud.

> I think it is a waste and big code duplication in each platform
> that does not have that special regulator.

Indeed
