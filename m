From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 04 Apr 2016 13:10:09 -0400
Subject: [PATCH for v4.7] arm: lpc32xx: remove leftovers of legacy
 clock source and provider drivers
In-Reply-To: <57029E6F.5050300@mleia.com>
References: <1456973180-31764-1-git-send-email-vz@mleia.com>
 <1459784558.25564.6.camel@localhost>  <57029E6F.5050300@mleia.com>
Message-ID: <1459789809.25564.9.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Mon, 2016-04-04 at 20:03 +0300, Vladimir Zapolskiy wrote:
> Hi Sylvain,
> 
> On 04.04.2016 18:42, Sylvain Lemieux wrote:
> > Hi Vladimir,
> > 
> > On Thu, 2016-03-03 at 04:46 +0200, Vladimir Zapolskiy wrote:
> >> After switching the platform to common clock framework there is no
> >> more need to keep dead code in arch/arm/mach-lpc32xx, which glued
> >> legacy clock source and clock provider drivers, remove the leftovers.
> >>
> >> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> >> ---
> >>  arch/arm/mach-lpc32xx/common.c | 95 ------------------------------------------
> >>  arch/arm/mach-lpc32xx/common.h | 23 +---------
> >>  2 files changed, 1 insertion(+), 117 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
> >> index 1cd8853..f03683f 100644
> >> --- a/arch/arm/mach-lpc32xx/common.h
> >> +++ b/arch/arm/mach-lpc32xx/common.h
> >> @@ -19,38 +19,17 @@
> >>  
> >>  #include <linux/reboot.h>
> >>  
> > It is possible to remove "reboot.h";
> > do you want me to send a separate patch for it?
> 
> I assume that removing of this #include entry is independent from my patch,
> and related to gone lpc32xx_restart, please send a fixup on top of v4.6-r1.
> 
yes, this is independent from this patch;
this is related to the previous patch on restart.

I will submit a separate patch for it.

> >>  extern void lpc23xx_restart(enum reboot_mode, const char *);
> >>  
> > The patch does not apply on 4.6-rc1;
> > can you send a version 2 of your patch based on the latest mainline?
> >
> 
> Right, the change requires a rebase, I'll send v2 shortly.
> 
> Thanks!
> 
> --
> With best wishes,
> Vladimir
