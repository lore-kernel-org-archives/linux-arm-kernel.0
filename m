From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 20 Jun 2014 11:57:45 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzJdIEFSTTogaS5NWCBzeXN0ZW06IFNpbXBsaWZ5IGhh?=
 =?UTF-8?B?bmRsaW5nIHdhdGNoZG9nIGNsb2Nr?=
In-Reply-To: <20140620075031.GC28225@dragon>
References: <1402644373-8408-1-git-send-email-shc_work@mail.ru>
 <1403239006.737527842@f277.i.mail.ru>
 <20140620075031.GC28225@dragon>
Message-ID: <1403251065.844555501@f422.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fri, 20 Jun 2014 15:50:34 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> On Fri, Jun 20, 2014 at 08:36:46AM +0400, Alexander Shiyan wrote:
> > Fri, 20 Jun 2014 12:26:52 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> > > On Fri, Jun 13, 2014 at 11:26:12AM +0400, Alexander Shiyan wrote:
> > > > This patch simplifies handling watchdog clock a bit.
> > > > As an additional change, now we properly check WDT clock in a reset
> > > > function.
> > > > 
> > > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > > ---
> > > >  arch/arm/mach-imx/system.c | 20 +++++++-------------
> > > >  1 file changed, 7 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
> > > > index 3b0733e..ae521f3 100644
> > > > --- a/arch/arm/mach-imx/system.c
> > > > +++ b/arch/arm/mach-imx/system.c
> > > > @@ -42,7 +42,7 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
> > > >  {
> > > >  	unsigned int wcr_enable;
> > > >  
> > > > -	if (wdog_clk)
> > > > +	if (!IS_ERR_OR_NULL(wdog_clk))
> > > 
> > > I think this should just be if (!IS_ERR(wdog_clk)).
> > 
> > No, this is a part of commit log.
> > wdog_clk can be NULL if mxc_arch_reset_init() is not called, 
> > so we just protect mxc_restart() for such cases.
> 
> I think clk API can take NULL as input.

You are right.
If this is the only issue on this series, could you fix it during the applying?

---
