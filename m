From: vjaquez@igalia.com (=?iso-8859-1?Q?V=EDctor_M=2E_J=E1quez_L=2E?=)
Date: Thu, 6 Oct 2011 18:26:14 +0200
Subject: [PATCH] omap: dmtimer: convert printk to pr_*
In-Reply-To: <1317914379.10495.5.camel@Joe-Laptop>
References: <1317898106-1891-1-git-send-email-vjaquez@igalia.com>
	<1317914379.10495.5.camel@Joe-Laptop>
Message-ID: <20111006162614.GH30222@lit.local.igalia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2011 at 08:19:39AM -0700, Joe Perches wrote:
> On Thu, 2011-10-06 at 12:48 +0200, V?ctor Manuel J?quez Leal wrote:
> > Convert all the printk(<level>) messages in the driver to pr_<level>().
> []
> > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> []
> > @@ -397,8 +397,7 @@ struct omap_dm_timer *omap_dm_timer_request_specific(int id)
> >  	spin_lock_irqsave(&dm_timer_lock, flags);
> >  	if (id <= 0 || id > dm_timer_count || dm_timers[id-1].reserved) {
> >  		spin_unlock_irqrestore(&dm_timer_lock, flags);
> > -		printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
> > -		       __FILE__, __LINE__, __func__, id);
> > +		pr_warning("unable to get timer %d\n", id);
> 
> For new conversions, please use pr_warn not pr_warning.
> It's shorter and similar to other dev_warn/netdev_warn
> uses.
> 
> >  		dump_stack();
> 
> To emit a message then dump stack, please use
> 	WARN(1, fmt, ...)
> 

Thanks a lot!

I'll do that and then resend.

vmjl
