From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 30 Dec 2010 19:00:26 +0800
Subject: [PATCH v3 1/8] ARM: mx5: use config to define boot related
	addresses
In-Reply-To: <20101230093127.GO14221@pengutronix.de>
References: <1293684968-7338-1-git-send-email-richard.zhao@freescale.com>
	<20101230093127.GO14221@pengutronix.de>
Message-ID: <20101230110026.GA30513@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 30, 2010 at 10:31:27AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Thu, Dec 30, 2010 at 12:56:02PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> > Because common clock is changing, I don't send out mx50 clock code.
> > But sure I tested the patch series using the clock code.
> > 
> >  arch/arm/mach-mx5/Makefile.boot |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
> > index 9939a19..fec7cd9 100644
> > --- a/arch/arm/mach-mx5/Makefile.boot
> > +++ b/arch/arm/mach-mx5/Makefile.boot
> > @@ -1,3 +1,3 @@
> > -   zreladdr-y	:= 0x90008000
> > -params_phys-y	:= 0x90000100
> > -initrd_phys-y	:= 0x90800000
> > +   zreladdr-$(CONFIG_ARCH_MX51)	:= 0x90008000
> > +params_phys-$(CONFIG_ARCH_MX51)	:= 0x90000100
> > +initrd_phys-$(CONFIG_ARCH_MX51)	:= 0x90800000
> looks good
> 
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Thanks.
For such patch acked, do I need to re-send it out when I send out v4 version
of the patch series?

Richard
> 
> This affects i.MX53 support, so we have to pay attention to merge order.
> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
