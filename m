From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 31 Dec 2010 10:01:57 +0800
Subject: [PATCH v3 1/8] ARM: mx5: use config to define boot related
	addresses
In-Reply-To: <20101230110506.GY14221@pengutronix.de>
References: <1293684968-7338-1-git-send-email-richard.zhao@freescale.com>
	<20101230093127.GO14221@pengutronix.de>
	<20101230110026.GA30513@shlinux1.ap.freescale.net>
	<20101230110506.GY14221@pengutronix.de>
Message-ID: <20101231020156.GG28246@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Thu, Dec 30, 2010 at 12:05:06PM +0100, Uwe Kleine-K?nig wrote:
> Hello Richard,
> 
> On Thu, Dec 30, 2010 at 07:00:26PM +0800, Richard Zhao wrote:
> > On Thu, Dec 30, 2010 at 10:31:27AM +0100, Uwe Kleine-K?nig wrote:
> > > On Thu, Dec 30, 2010 at 12:56:02PM +0800, Richard Zhao wrote:
> > > > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > > > ---
> > > > Because common clock is changing, I don't send out mx50 clock code.
> > > > But sure I tested the patch series using the clock code.
> > > > 
> > > >  arch/arm/mach-mx5/Makefile.boot |    6 +++---
> > > >  1 files changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
> > > > index 9939a19..fec7cd9 100644
> > > > --- a/arch/arm/mach-mx5/Makefile.boot
> > > > +++ b/arch/arm/mach-mx5/Makefile.boot
> > > > @@ -1,3 +1,3 @@
> > > > -   zreladdr-y	:= 0x90008000
> > > > -params_phys-y	:= 0x90000100
> > > > -initrd_phys-y	:= 0x90800000
> > > > +   zreladdr-$(CONFIG_ARCH_MX51)	:= 0x90008000
> > > > +params_phys-$(CONFIG_ARCH_MX51)	:= 0x90000100
> > > > +initrd_phys-$(CONFIG_ARCH_MX51)	:= 0x90800000
> > > looks good
> > > 
> > > Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Thanks.
> > For such patch acked, do I need to re-send it out when I send out v4 version
> > of the patch series?
> As I'm not the imx-maintainer, I'd say yes, send it out (with my ack
> added) in v4.
> 
Richard was trying to understand the correct approach for sending
patch series.

I used to only send the updated patches in the new patch series
since the last series version, while Richard prefer to send all
the patches in the very single version, even most of them are not
changed since the last version.

I think the sending delta way could save bandwidth and ease reviewing
a little bit, while sending all may be easy for people to pick up
the patches. So what is the preference for you guys?

> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Regards,
Shawn
