From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 9 Sep 2010 10:41:20 +0100
Subject: [PATCH v2] Input: Make ADS7846 independent on regulator
In-Reply-To: <201009091027.18176.marek.vasut@gmail.com>
References: <1280560182-7071-1-git-send-email-marek.vasut@gmail.com>
	<4C862EB3.4080006@compulab.co.il>
	<20100907125335.GD25830@sirena.org.uk>
	<201009091027.18176.marek.vasut@gmail.com>
Message-ID: <20100909094120.GB1988@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 09, 2010 at 10:27:17AM +0200, Marek Vasut wrote:
> Dne ?t 7. z??? 2010 14:53:35 Mark Brown napsal(a):

> > From a regulator API usage point of view a separate implementation of
> > the same thing was nacked - there are regulator API facilties for hiding
> > missing regulators from drivers when needed to get systems going, unless
> > the device genuinely can cope without supplies it should be relying on
> > those.

> Maybe these platforms should have been fixed prior to applying the patch adding 
> regulator goo into ads7846 driver then. What's the way to go now then ?

Fix the platforms and use the dummy regulators to keep them going until
that happens.  It's trivial to do the hookup in the platforms.
