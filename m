From: eduardo.valentin@nokia.com (Eduardo Valentin)
Date: Tue, 11 May 2010 19:58:46 +0300
Subject: [PATCHv5 2/3] OMAP: export OMAP info under /proc/socinfo
In-Reply-To: <4BE9697F.80308@ti.com>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>
	<1273587331-24604-3-git-send-email-eduardo.valentin@nokia.com>
	<4BE9697F.80308@ti.com>
Message-ID: <20100511165846.GA10609@besouro.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nishanth,

On Tue, May 11, 2010 at 04:28:15PM +0200, ext Nishanth Menon wrote:
> Eduardo Valentin had written, on 05/11/2010 09:15 AM, the following:
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> > 
> > Export OMAP name and rev under /proc/socinfo node.
> > 
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> > ---
> >  arch/arm/Kconfig         |    1 +
> >  arch/arm/mach-omap1/id.c |   31 ++++++++++++++++++++++++-------
> >  arch/arm/mach-omap2/id.c |   32 ++++++++++++++++++++++++++------
> >  3 files changed, 51 insertions(+), 13 deletions(-)
> > 
> [..]
> 
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index 37b8a1a..b67486b 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> [..]
> 
> > @@ -356,7 +363,8 @@ void __init omap3_cpuinfo(void)
> >  	}
> >  
> >  	/* Print verbose information */
> > -	pr_info("%s ES%s (", cpu_name, cpu_rev);
> > +	snprintf(socinfo, SOCINFO_SZ, "%s ES%s", cpu_name, cpu_rev);
> > +	pr_info("%s (", socinfo);
> >  
> >  	OMAP3_SHOW_FEATURE(l2cache);
> >  	OMAP3_SHOW_FEATURE(iva);
> Just a minor comment -> is it a good idea to pushin the features to SOC 
> info as well? currently this is being displayed at bootlog and not 
> beyond.. might be a better approach to move it into socinfo..

Yeah. I would expect that someone would ask this. When I was writing this part
I also thought that would be nice to just duplicate all info which is printed
into kernel log buffer. But then I decided to proceed with only the info we are
needing from userspace. If you think that would be useful to know those as well,
then why not adding them.

> 
> 
> [..]
> 
> -- 
> Regards,
> Nishanth Menon
