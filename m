From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 19 Nov 2009 10:37:17 +0000
Subject: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from
	Arnaud Patard.
In-Reply-To: <1258609615.2676.31.camel@shinel>
References: <20091118232939.201290297@fluff.org.uk>
	<20091118232948.063635416@fluff.org.uk>
	<1258609615.2676.31.camel@shinel>
Message-ID: <20091119103717.GC15460@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 01:46:55PM +0800, Shine Liu wrote:
> On Wed, 2009-11-18 at 23:29 +0000, Ben Dooks wrote:

> > +config TOUCHSCREEN_S3C2410
> > +       tristate "Samsung S3C2410 touchscreen input driver"
> > +       depends on ARCH_S3C2410 && INPUT && INPUT_TOUCHSCREEN
> > +       select SERIO
> > +       help
> > +         Say Y here if you have the s3c2410 touchscreen.
> > +
> > +         If unsure, say N.
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called s3c2410_ts.

> S3C24XX_ADC should be added to the depends.

It's probably more friendly to select rather than depend on it to avoid
the option being hidden.
