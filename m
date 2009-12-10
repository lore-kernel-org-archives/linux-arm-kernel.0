From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 10 Dec 2009 16:57:18 +0530
Subject: [PATCH 3/6] OMAP4: Re-arrange the low level debug code
In-Reply-To: <4B20CF04.8060208@ru.mvista.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-2-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-3-git-send-email-santosh.shilimkar@ti.com>
	<4B20CF04.8060208@ru.mvista.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A8766@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov at ru.mvista.com]
> Sent: Thursday, December 10, 2009 4:06 PM
> To: Shilimkar, Santosh
> Cc: tony at atomide.com; linux-omap at vger.kernel.org; linux at arm.linux.org.uk; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 3/6] OMAP4: Re-arrange the low level debug code
> 
> Hello.
> 
> Santosh Shilimkar wrote:
> 
> > On OMAP4430 the UART3 base address is different than that on OMAP3.
> > Because of this existing code needs additional #ifdef'ry to accommodate
> > that code. Hence this patch separates it. Also UART3 base address is
> > fixed for OMAP4430 in this patch.
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >
> [...]
> > diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-
> omap2/include/mach/debug-macro.S
> > index e9f255d..b2b4b29 100644
> > --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
> > +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
> > @@ -25,7 +25,7 @@
> >  		add	\rx, \rx, #0x00004000	@ UART 3
> >  #endif
> >
> > -#elif defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> > +#elif CONFIG_ARCH_OMAP3
> >
> 
>    Why you've dropped defined()? This doesn't seem right as it should
> cause error when CONFIG_ARCH_OMAP3=n...

Before omap4 support was added, it was as above. Now when I decided
to go back and spilt it I changed it. How the ARCH flag will be
n ? It will be either 0 or 1
