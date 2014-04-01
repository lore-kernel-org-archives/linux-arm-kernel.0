From: tthayer@altera.com (Thor Thayer - Sendmail)
Date: Tue, 1 Apr 2014 15:05:12 -0500
Subject: [PATCH 2/2] arm: socfpga: Add support for Altera SoC SDRAM
 controller
In-Reply-To: <20140401053343.GO5052@pengutronix.de>
References: <1396303627-29198-1-git-send-email-tthayer@altera.com>
 <1396303627-29198-3-git-send-email-tthayer@altera.com>
 <20140401053343.GO5052@pengutronix.de>
Message-ID: <1396382712.20336.2.camel@dinh-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-04-01 at 07:33 +0200, Steffen Trumtrar wrote:
> On Mon, Mar 31, 2014 at 05:07:07PM -0500, tthayer at altera.com wrote:
> > From: Thor Thayer <tthayer@altera.com>
> > 
<snip>
> >  
> 
> Can't we get rid of all these global pointers instead of adding to them?

Yes. I will remove this file from the patch. Thanks.

> 
> > @@ -150,6 +151,15 @@ void __init socfpga_sysmgr_init(void)
> >  
> >  	np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
> >  	clk_mgr_base_addr = of_iomap(np, 0);
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "altr,sdr-ctl");
> > +	if (!np) {
> > +		pr_err("SOCFPGA: Unable to find sdr-ctl\n");
> > +		return;
> > +	}
> > +
> > +	sdr_ctl_base_addr = of_iomap(np, 0);
> > +	WARN_ON(!sdr_ctl_base_addr);
> >  }
> >  
> >  static void __init socfpga_init_irq(void)
> > -- 
> > 1.7.9.5
> > 
> 
