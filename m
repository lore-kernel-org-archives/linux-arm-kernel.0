From: srk@ti.com (Govindarajan, Sriramakrishnan)
Date: Fri, 13 Nov 2009 16:34:10 +0530
Subject: NAND: failure reported with mtd_oobtest(read delay violated)
In-Reply-To: <20091112205910.GB11304@n2100.arm.linux.org.uk>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA5CC012@dbde02.ent.ti.com>
	<20091112205910.GB11304@n2100.arm.linux.org.uk>
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA5CC42B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, November 13, 2009 2:29 AM
> To: Govindarajan, Sriramakrishnan
> Cc: 'linux-mtd at lists.infradead.org'; 'linux-arm-
> kernel at lists.infradead.org'
> Subject: Re: NAND: failure reported with mtd_oobtest(read delay violated)
> 
> On Thu, Nov 12, 2009 at 09:28:58PM +0530, Govindarajan, Sriramakrishnan
> wrote:
> > OMAP3EVM implementation relies on command delay(chip_delay set to 50ms)
> > and doesn't use wait pin monitoring. By adding a data memory barrier
> > dmb() instruction right after the command phase the issue seems to be
> > resolved.
> 
> Clearly adding ARM specific calls into generic code is the wrong thing
> to do...  Why can't this dmb() go into whatever NAND driver OMAP is using?

Russell, thanks for the comments. But I posed this question
assuming that this a more generic problem that may show up on other
rchitectures/platforms where the NAND driver is using delay loop
instead of wait pin monitoring. Is there a more generic alternative?

Also, the time delay is implemented in the nand(nand_base.c) core file itself - there aren't platform specific hooks for us to override/customize for OMAP specifically. I am also looking at the other alternative of using wait pin monitoring instead

Regards
Sriram
