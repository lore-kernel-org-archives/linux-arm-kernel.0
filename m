From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 24 Jul 2015 08:29:48 +0200
Subject: [PATCH v2] thermal: consistently use int for temperatures
In-Reply-To: <20150723120759.GA17690@amd>
References: <1437463292-24844-1-git-send-email-s.hauer@pengutronix.de>
 <20150723120759.GA17690@amd>
Message-ID: <20150724062948.GK18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 02:07:59PM +0200, Pavel Machek wrote:
> On Tue 2015-07-21 09:21:32, Sascha Hauer wrote:
> > The thermal code uses int, long and unsigned long for temperatures
> > in different places.
> > 
> > Using an unsigned type limits the thermal framework to positive
> > temperatures without need. Also several drivers currently will report
> > temperatures near UINT_MAX for temperatures below 0?C. This will probably
> > immediately shut the machine down due to overtemperature if started below
> > 0?C.
> > 
> > 'long' is 64bit on several architectures. This is not needed since INT_MAX ?mC
> > is above the melting point of all known materials.
> 
> Can we do something like
> 
> typedef millicelsius_t int;
> 
> ...to document the units?

I am not very fond of typedefs and I am not sure this adds any value. I
could change it when more people ask for it, but I just sent the new
version without this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
