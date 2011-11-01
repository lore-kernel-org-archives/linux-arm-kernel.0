From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Nov 2011 17:56:23 +0000
Subject: [PATCH 3/5] ARM: restart: remove local_irq_disable() from
	within arch_reset()
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F39DF7767A@AUSP01VMBX24.collaborationhost.net>
References: <20111101160731.GQ19187@n2100.arm.linux.org.uk>
	<E1RLGtg-0005IV-TG@rmk-PC.arm.linux.org.uk>
	<ADE657CA350FB648AAC2C43247A983F001F39DF7767A@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20111101175623.GT19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 01, 2011 at 11:36:14AM -0500, H Hartley Sweeten wrote:
> > diff --git a/arch/arm/mach-ep93xx/include/mach/system.h b/arch/arm/mach-ep93xx/include/mach/system.h
> > index 6d661fe..bdf6c4f 100644
> > --- a/arch/arm/mach-ep93xx/include/mach/system.h
> > +++ b/arch/arm/mach-ep93xx/include/mach/system.h
> > @@ -11,8 +11,6 @@ static inline void arch_idle(void)
> >  
> >  static inline void arch_reset(char mode, const char *cmd)
> >  {
> > -	local_irq_disable();
> > -
> >  	/*
> >  	 * Set then clear the SWRST bit to initiate a software reset
> >  	 */
> 
> For ep93xx.
> 
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks.  I noticed that u300 had a comment which should've been deleted,
so I've also done that and removed the spatch from the commit log (as it
no longer reflects the patch.)
