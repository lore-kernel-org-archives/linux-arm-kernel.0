From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 11 Jun 2010 06:55:07 +0200
Subject: [PATCH 0/5] Makefile.boot cleanup
In-Reply-To: <alpine.LFD.2.00.1006101442130.30664@xanadu.home>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<20100603075704.GB336@pengutronix.de>
	<alpine.LFD.2.00.1006101442130.30664@xanadu.home>
Message-ID: <20100611045507.GA10894@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 10, 2010 at 02:44:53PM -0400, Nicolas Pitre wrote:
> On Thu, 3 Jun 2010, Uwe Kleine-K?nig wrote:
> 
> > Hello Eric,
> > 
> > On Thu, Jun 03, 2010 at 03:36:48PM +0800, Eric Miao wrote:
> > > Several facts:
> > > 
> > > 1. ZRELADDR in most cases can be auto detected by maksing PC with
> > >    0xf000_0000 if the zImage is placed within the first 256MiB from
> > >    the memory start, which is a sane assumption except for:
> > > 
> > >    - when ARCH_MX1 or ARCH_SHARK is defined
> > >    - when ARCH_U300 is defined (U300 really is strange when defining
> > >      PHYS_OFFSET and ZRELADDR)
> > >    - or when ZBOOT_ROM is defined
> > If you guess ZRELADDR based on sp instead of pc it even should work if
> > ZBOOT_ROM is defined?!
> 
> If you're using ZBOOT_ROM that means you want to execute zImage directly 
> from ROM.  This is therefore a highly customized configuration.  In that 
> context, having a variable phys-offset doesn't make much sense to start 
> with.
Right, but then the kernel needs to know this fixed value for
phys-offset.  In the patches presented by Eric the person configuring
the kernel needs to know that value.  When guessing based on sp she
doesn't need to read addional docs when enabling ZBOOT_ROM.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
