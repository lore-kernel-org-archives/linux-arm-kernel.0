From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 7 Feb 2013 15:05:03 -0500 (EST)
Subject: [RFC PATCH] ARM: Export the CPU logical map to modules
In-Reply-To: <20130207122253.GA2309@linaro.org>
References: <1359394444-16610-1-git-send-email-dave.martin@linaro.org>
 <20130207122253.GA2309@linaro.org>
Message-ID: <alpine.LFD.2.02.1302071457070.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Feb 2013, Dave Martin wrote:

> Hi,
> 
> Does anyone have a comment on this?

As you say, I'd be tempted to export some accessor with well defined 
semantic meaning instead.



> 
> Cheers
> ---Dave
> 
> On Mon, Jan 28, 2013 at 05:34:04PM +0000, Dave Martin wrote:
> > It is reasonable for loadable modules to be CPU topology aware
> > (particular examples include cpufreq and cpuidle drivers).
> > 
> > This patch exports __cpu_logical_map, so that modules can use the
> > cpu_logical_map() interface declared in <asm/smp_plat.h>.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > ---
> > If anyone has a strong view on whether this should be
> > EXPORT_SYMBOL_GPL(), I don't have a problem with changing
> > that.  I'm not sure of the precise etiquette here.
> > Certainly this does not feel like a very "public" interface.
> > 
> > Perhaps we should wrap this in a real function for export
> > to modules, rather than encouraging them to poke the
> > __cpu_logical_map[] array (albeit via a predefined macro).
> > 
> > 
> >  arch/arm/kernel/setup.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 3f6cbb2..1b9e5bf 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -428,6 +428,7 @@ void cpu_init(void)
> >  }
> >  
> >  int __cpu_logical_map[NR_CPUS];
> > +EXPORT_SYMBOL(__cpu_logical_map);
> >  
> >  void __init smp_setup_processor_id(void)
> >  {
> > -- 
> > 1.7.4.1
> > 
> 
