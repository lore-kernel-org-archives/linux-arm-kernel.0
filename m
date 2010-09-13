From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Sep 2010 12:26:15 +0100
Subject: [PATCH] ux500: add CPU hotplug support
In-Reply-To: <20100913110632.GC30787@n2100.arm.linux.org.uk>
References: <1284375698-1824-1-git-send-email-sundar.iyer@stericsson.com>
	<20100913110632.GC30787@n2100.arm.linux.org.uk>
Message-ID: <1284377175.31819.2.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-09-13 at 12:06 +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 13, 2010 at 04:31:38PM +0530, Sundar Iyer wrote:
> > diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
> > index 438ef16..ade2e17 100644
> > --- a/arch/arm/mach-ux500/platsmp.c
> > +++ b/arch/arm/mach-ux500/platsmp.c
> > @@ -26,7 +26,7 @@
> >   * control for which core is the next to come out of the secondary
> >   * boot "holding pen"
> >   */
> > -volatile int __cpuinitdata pen_release = -1;
> > +volatile int pen_release = -1;
> 
> This looks like an unnecessary change.

I think it avoids a build warning about mismatched sections but that's
probably the wrong way to fix. We get similar warnings on Versatile
Express and RealView when hotplug is enabled but I haven't had the time
to investigate properly.

-- 
Catalin
