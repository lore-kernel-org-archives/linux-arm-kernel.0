From: liviu@dudau.co.uk (Liviu Dudau)
Date: Sat, 14 Feb 2015 01:34:34 +0000
Subject: [PATCH 01/11] ARM: vexpress: use ARM_CPU_SUSPEND if needed
In-Reply-To: <alpine.LFD.2.11.1502140649560.25300@knanqh.ubzr>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-2-git-send-email-arnd@arndb.de>
 <20150213103716.GQ14954@e106497-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1502140649560.25300@knanqh.ubzr>
Message-ID: <20150214013433.GA4194@bart.dudau.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 14, 2015 at 06:55:05AM +0800, Nicolas Pitre wrote:
> On Fri, 13 Feb 2015, Liviu Dudau wrote:
> 
> > On Thu, Feb 12, 2015 at 07:42:33PM +0000, Arnd Bergmann wrote:
> > > The vexpress tc2 power management code calls mcpm_loopback, which
> > > is only available if ARM_CPU_SUSPEND is enabled, otherwise we
> > > get a link error:
> > > 
> > > arch/arm/mach-vexpress/built-in.o: In function `tc2_pm_init':
> > > arch/arm/mach-vexpress/tc2_pm.c:389: undefined reference to `mcpm_loopback'
> > 
> > Arnd,
> > 
> > We are having reports of TC2 not booting with MCPM enabled. Lorenzo
> > was investigating this but then headed for Linaro Connect this week,
> > so we don't have yet a resolution. Can this patch be postponed for
> > a later -rc?
> 
> Can you share those reports?  I did boot my TC2 with v3.19-rc7 before 
> leaving for Linaro Connect and it just worked.
> 
> Regardless, this patch is about a build fix and doesn't change any 
> functionality, so I wouldn't postpone it.
> 

OK. Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

Best regards,
Liviu

> 
> 
> > 
> > Best regards,
> > Liviu
> > 
> > 
> > > 
> > > This explicitly selects ARM_CPU_SUSPEND like other platforms that
> > > need it.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Fixes: 3592d7e002438 ("ARM: 8082/1: TC2: test the MCPM loopback during boot")
> > > Cc: Nicolas Pitre <nico@linaro.org>
> > > Cc: Kevin Hilman <khilman@linaro.org>
> > > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > ---
> > >  arch/arm/mach-vexpress/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> > > index d6b16d9a7838..3c2509b4b694 100644
> > > --- a/arch/arm/mach-vexpress/Kconfig
> > > +++ b/arch/arm/mach-vexpress/Kconfig
> > > @@ -73,6 +73,7 @@ config ARCH_VEXPRESS_TC2_PM
> > >  	depends on MCPM
> > >  	select ARM_CCI
> > >  	select ARCH_VEXPRESS_SPC
> > > +	select ARM_CPU_SUSPEND
> > >  	help
> > >  	  Support for CPU and cluster power management on Versatile Express
> > >  	  with a TC2 (A15x2 A7x3) big.LITTLE core tile.
> > > -- 
> > > 2.1.0.rc2
> > > 
> > > 
> > 
> > -- 
> > ====================
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ?\_(?)_/?
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 


-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...
