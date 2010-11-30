From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Nov 2010 15:35:06 +0100
Subject: [PATCH] make mc13783 code generic
In-Reply-To: <878w0buqd9.fsf@lechat.rtp-net.org>
References: <AANLkTimfDHRXZjB5=Ld9YSFzqh-hVWUTy-TQFV=GEaGA@mail.gmail.com>
	<878w0buqd9.fsf@lechat.rtp-net.org>
Message-ID: <20101130143506.GJ20449@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Nov 30, 2010 at 10:12:34AM +0100, Arnaud Patard wrote:
> > diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> > index bff8157..4008bf6 100644
> > --- a/drivers/regulator/Makefile
> > +++ b/drivers/regulator/Makefile
> > @@ -29,7 +29,7 @@ obj-$(CONFIG_REGULATOR_TPS6586X) += tps6586x-regulator.o
> >  obj-$(CONFIG_REGULATOR_DA903X)	+= da903x.o
> >  obj-$(CONFIG_REGULATOR_PCF50633) += pcf50633-regulator.o
> >  obj-$(CONFIG_REGULATOR_PCAP) += pcap-regulator.o
> > -obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o
> > +obj-$(CONFIG_REGULATOR_MC13783) += mc13783-regulator.o mc13xxx-regulator-core.o
> >  obj-$(CONFIG_REGULATOR_AB3100) += ab3100.o
> 
> Why don't you add a common Kconfig entry ? I've the (wrong ?) feeling
> that you're going to do :
> obj-$(CONFIG_REGULATOR_MC13892) += mc13892-regulator.o mc13xxx-regulator-core.o
> 
> which should be avoided. Being able to build mc13783 and mc13892 support
> at the same time is a must-have imho.
AFAIK using this idiom is just fine.  You could argue that it's cleaner
to have a CONFIG_REGULATOR_MC13XXX, but the result should be identical.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
