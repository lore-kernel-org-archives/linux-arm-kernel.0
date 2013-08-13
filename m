From: nico@linaro.org (Nicolas Pitre)
Date: Tue, 13 Aug 2013 11:50:17 -0400 (EDT)
Subject: Build error: versatile express
In-Reply-To: <20130813105227.GC2823@localhost.localdomain>
References: <20130812124801.GB2823@localhost.localdomain>
 <alpine.LFD.2.03.1308121125420.14472@syhkavp.arg>
 <20130813105227.GC2823@localhost.localdomain>
Message-ID: <alpine.LFD.2.03.1308131148380.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Aug 2013, Dave Martin wrote:

> On Mon, Aug 12, 2013 at 12:55:23PM -0400, Nicolas Pitre wrote:
> > On Mon, 12 Aug 2013, Dave Martin wrote:
> > 
> > > On Mon, Aug 12, 2013 at 11:28:04AM +0100, Russell King - ARM Linux wrote:
> > > > arch/arm/mach-vexpress/tc2_pm.c: In function 'tc2_pm_down.clone.0':
> > > > arch/arm/mach-vexpress/tc2_pm.c:200:1: error: fp cannot be used in asm here
> > > > 
> > > > This is caused by the assembly code in this file clobbering R11, which
> > > > is incompatible with having CONFIG_FRAME_POINTER=y.
> > > 
> > > Is there any reason not to fix this just by pushing/popping r11 inside
> > > the asm and removing it from the clobber list?
> > 
> > That's most likely the best fix.  What about this?
> 
> Were we replacing these instances with the macro, or is that still in
> flight?

I've updated the macro patch accordingly.  I prefer to submit that one 
separately.

> Anyway, if useful:
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Thanks.


Nicolas
