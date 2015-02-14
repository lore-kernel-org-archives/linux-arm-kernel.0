From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Sat, 14 Feb 2015 20:42:21 +0000
Subject: [PATCH 01/11] ARM: vexpress: use ARM_CPU_SUSPEND if needed
In-Reply-To: <20150214013433.GA4194@bart.dudau.co.uk>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-2-git-send-email-arnd@arndb.de>
 <20150213103716.GQ14954@e106497-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1502140649560.25300@knanqh.ubzr>
 <20150214013433.GA4194@bart.dudau.co.uk>
Message-ID: <20150214204221.GB3932@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 14, 2015 at 01:34:34AM +0000, Liviu Dudau wrote:
> On Sat, Feb 14, 2015 at 06:55:05AM +0800, Nicolas Pitre wrote:
> > On Fri, 13 Feb 2015, Liviu Dudau wrote:
> > 
> > > On Thu, Feb 12, 2015 at 07:42:33PM +0000, Arnd Bergmann wrote:
> > > > The vexpress tc2 power management code calls mcpm_loopback, which
> > > > is only available if ARM_CPU_SUSPEND is enabled, otherwise we
> > > > get a link error:
> > > > 
> > > > arch/arm/mach-vexpress/built-in.o: In function `tc2_pm_init':
> > > > arch/arm/mach-vexpress/tc2_pm.c:389: undefined reference to `mcpm_loopback'
> > > 
> > > Arnd,
> > > 
> > > We are having reports of TC2 not booting with MCPM enabled. Lorenzo
> > > was investigating this but then headed for Linaro Connect this week,
> > > so we don't have yet a resolution. Can this patch be postponed for
> > > a later -rc?
> > 
> > Can you share those reports?  I did boot my TC2 with v3.19-rc7 before 
> > leaving for Linaro Connect and it just worked.
> > 
> > Regardless, this patch is about a build fix and doesn't change any 
> > functionality, so I wouldn't postpone it.
> > 
> 
> OK. Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

There is no reason to postpone it, even though TC2 builds with MCPM
enabled and both bL switcher and bL CPUidle driver disabled are
questionable but possible.

There are other issues with PM on TC2 that are not related to this
patch anyway, they can't be since this is a fix for a build issue on
a config that does not enable any PM at all.

Lorenzo
