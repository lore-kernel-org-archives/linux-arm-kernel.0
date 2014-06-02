From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Mon, 2 Jun 2014 12:27:50 +0200
Subject: [PATCH 1/5] ARM: berlin: add SMP support
In-Reply-To: <20140602100332.GH28090@lunn.ch>
References: <1401700866-24804-1-git-send-email-antoine.tenart@free-electrons.com>
 <1401700866-24804-2-git-send-email-antoine.tenart@free-electrons.com>
 <20140602094715.GG28090@lunn.ch> <20140602100048.GA12162@kwain>
 <20140602100332.GH28090@lunn.ch>
Message-ID: <20140602102750.GB13681@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 12:03:32PM +0200, Andrew Lunn wrote:
> On Mon, Jun 02, 2014 at 12:00:48PM +0200, Antoine T?nart wrote:
> > Hi Andrew,
> > 
> > On Mon, Jun 02, 2014 at 11:47:15AM +0200, Andrew Lunn wrote:
> > > On Mon, Jun 02, 2014 at 11:21:02AM +0200, Antoine T?nart wrote:
> > > > +
> > > > +static inline void berlin_reset_cpu(unsigned int cpu)
> > > > +{
> > > > +	u32 val;
> > > > +
> > > > +	val = readl(cpu_ctrl + CPU_RESET);
> > > > +	val |= BIT(cpu_logical_map(cpu));
> > > > +	writel(val, cpu_ctrl + CPU_RESET);
> > > > +}
> > > 
> > > Is this performing a reset on the CPU, or is it taking it out of reset?
> > > 
> > > If you are going to implement CPU hotplug at some point, you are going
> > > to want to be able to put the CPU into reset, i.e. power it off, and
> > > take it out of reset, i.e. power it on and getting it running. So it
> > > might help if we get these function names clear now.
> > 
> > It is performing a reset on the CPU. berlin_perform_reset_cpu() then?
> 
> What happens if the CPU is powered off? Will a reset power it on?  Or
> are you assuming the boot loader has powered it on?

I actually don't have information about this. For now let's assume the
boot loader has powered on the CPUs.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
