From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 19 Oct 2015 14:41:35 +0200
Subject: [PATCH v2 1/3] ARM: catch pending imprecise abort on unmask
In-Reply-To: <20151015153246.GH32536@n2100.arm.linux.org.uk>
References: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
 <1444905142-21500-2-git-send-email-l.stach@pengutronix.de>
 <20151015153246.GH32536@n2100.arm.linux.org.uk>
Message-ID: <1445258495.3174.36.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 15.10.2015, 16:32 +0100 schrieb Russell King - ARM
Linux:
> On Thu, Oct 15, 2015 at 12:32:20PM +0200, Lucas Stach wrote:
> > Install a non-faulting handler just before unmasking imprecise aborts
> > and switch back to the regular one after unmasking is done.
> > 
> > This catches any pending imprecise abort that the firmware/bootloader
> > may have left behind that would normally crash the kernel at that point.
> > As there are apparently a lot of bootlaoders out there that do such a
> > thing it makes sense to handle it in the common startup code.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Much better.  Please feel free to add it to the patch system, thanks.
> 
> I think, given that the original seems to be breaking platforms, this
> patch needs to go into -rc kernels, right?
> 
Okay, this is in the patch system as patch 8447/1 now.

As Russell hasn't said whether he would like to pick up the platform
patches I've omitted them for now and would ask the platform maintainers
to pick them up themselves for kernel 4.4.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
