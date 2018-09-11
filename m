From: tony@atomide.com (Tony Lindgren)
Date: Tue, 11 Sep 2018 16:28:05 -0700
Subject: [PATCH] gpio: omap: Remove custom PM calls and use cpu_pm instead
In-Reply-To: <20180911194035.GA2180@lenoch>
References: <20180911183729.17110-1-tony@atomide.com>
 <20180911194035.GA2180@lenoch>
Message-ID: <20180911232805.GE5662@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ladislav Michl <ladis@linux-mips.org> [180911 19:44]:
> Tony,
> 
> On Tue, Sep 11, 2018 at 11:37:29AM -0700, Tony Lindgren wrote:
> > For a long time the gpio-omap custom PM calls have been annoying me so
> > let's replace them with cpu_pm instead. This will enable GPIO PM for
> > deeper idle states on omap4. And we can handle GPIO PM for omap2/3/4
> > in the same way.
> > 
> > Note that with this patch we are also slightly changing GPIO PM to be
> > less aggressive for omap3 and only will idle GPIO when PER context
> > may be lost.
> 
> I do not think it will make things any worse, but will run my favorite
> latency on test on this patch :)

Thanks I was hoping you'd do that :)

> Meanwhile see nit bellow.

> > +	switch (cmd) {
> > +	case CPU_CLUSTER_PM_ENTER:
> > +		/* Gets cleard on runtime_suspend */
> 
> "Gets cleared" perhaps...

Thanks will fix and post v2 after waiting few days for
comments.

Regards,

Tony
