From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 30 Mar 2012 17:11:51 +0800
Subject: [PATCH v3 1/1] ARM: imx28: add basic dt support
In-Reply-To: <20120330085103.GF3254@S2101-09.ap.freescale.net>
References: <1333089130-24832-1-git-send-email-b29396@freescale.com>
 <20120330085103.GF3254@S2101-09.ap.freescale.net>
Message-ID: <20120330091150.GA21517@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 04:51:06PM +0800, Shawn Guo wrote:
> I tried to apply the patch, but ...
> 
> On Fri, Mar 30, 2012 at 02:32:10PM +0800, Dong Aisheng wrote:
> ...
> > +static int __init mxs_icoll_add_irq_domain(struct device_node *np,
> > +				struct device_node *interrupt_parent)
> > +{
> > +	irq_domain_add_simple(np, 0);
> 
> The irq_domain_add_simple() has been removed from mainline.  You need
> a rebase against Linus' tree.
> 
Will rebase.

> > +static struct sys_timer imx28_timer = {
> > +	.init = imx28_timer_init,
> > +};
> > +
> > +static void __init mxs_machine_init(void)
> > +{
> > +       of_platform_populate(NULL, of_default_bus_match_table,
> 
> Given by checkpatch:
> 
> WARNING: please, no spaces at the start of a line
> #565: FILE: arch/arm/mach-mxs/mach-mxs.c:51:
> +       of_platform_populate(NULL, of_default_bus_match_table,$
> 
Hmm, it seems my checkpatch is out of date.
With new checkpatch i found it.

Regards
Dong Aisheng
