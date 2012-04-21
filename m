From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 21 Apr 2012 14:50:54 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCAxMi8xN10gQVJNIGNscHM3MTF4OiBTaW1wbGUgb3B0?=
 =?UTF-8?B?aW1pc2UgZGVidWdfbWFjcm8gYnkgcmVtb3Zpbmcgb25lIE5PUA==?=
In-Reply-To: <20120421104627.GD24211@n2100.arm.linux.org.uk>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
 <1334999490-27177-13-git-send-email-shc_work@mail.ru>
 <20120421104627.GD24211@n2100.arm.linux.org.uk>
Message-ID: <E1SLXu2-0004zV-VD.shc_work-mail-ru@f280.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sat, 21 Apr 2012 11:46:27 +0100 ?? Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sat, Apr 21, 2012 at 01:11:25PM +0400, Alexander Shiyan wrote:
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  arch/arm/mach-clps711x/include/mach/debug-macro.S |    6 ++----
> >  1 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/mach-clps711x/include/mach/debug-macro.S b/arch/arm/mach-clps711x/include/mach/debug-macro.S
> > index 118b3d9..37c4d8a 100644
> > --- a/arch/arm/mach-clps711x/include/mach/debug-macro.S
> > +++ b/arch/arm/mach-clps711x/include/mach/debug-macro.S
> > @@ -14,10 +14,8 @@
> >  #include <mach/hardware.h>
> >  
> >  		.macro	addruart, rp, rv, tmp
> > -#ifndef CONFIG_DEBUG_CLPS711X_UART2
> > -		mov	\rp, #0x0000	@ UART1
> > -#else
> > -		mov	\rp, #0x1000	@ UART2
> > +#ifdef CONFIG_DEBUG_CLPS711X_UART2
> > +		mov	\rp, #0x1000	@ Add offset for UART2 base reg
> >  #endif
> 
> This looks wrong.  How is rp initialized if CONFIG_DEBUG_CLPS711X_UART2 is
> not set?
You are right. My mistake.
