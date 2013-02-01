From: pavel@denx.de (Pavel Machek)
Date: Fri, 1 Feb 2013 11:46:55 +0100
Subject: [PATCHv2 for soc 4/4] arm: socfpga: Add SMP support for actual
 socfpga harware
In-Reply-To: <20130201035040.GE4838@quad.lixom.net>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-5-git-send-email-dinguyen@altera.com>
 <20130201035040.GE4838@quad.lixom.net>
Message-ID: <20130201104655.GA3124@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Because the CPU1 start address is different for socfpga-vt and
> > socfpga-cyclone5, we add code to use the correct CPU1 start addr.

> > @@ -72,6 +73,13 @@ void __init socfpga_sysmgr_init(void)
> >  	struct device_node *np;
> >  
> >  	np = of_find_compatible_node(NULL, NULL, "altr,sys-mgr");
> > +
> > +	if (of_property_read_u32(np, "cpu1-start-addr",
> > +			(u32 *) &cpu1start_addr)) {
> > +		early_printk("Need cpu1-start-addr in device tree.\n");
> > +		panic("Need cpu1-start-addr in device tree.\n");
> > +	}
> > +
> >  	sys_manager_base_addr = of_iomap(np, 0);
> 
> Wouldn't it be easier to diagnose this failure if you just printed the error
> and continued booting without the second CPU? An early panic is usually really
> hard to debug since you might not get early console without extra work.

I actually thought about that... but could not think of non-ugly way
of doing that. I hope dts will normally be "right" for any production
system...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
