From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Jan 2013 14:41:40 +0800
Subject: [PATCH v3 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <20130127172358.GM29973@lunn.ch>
References: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
 <1359281244-31455-2-git-send-email-andrew@lunn.ch>
 <20130127171111.GG23505@n2100.arm.linux.org.uk>
 <20130127172358.GM29973@lunn.ch>
Message-ID: <20130128064137.GA20238@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 06:23:58PM +0100, Andrew Lunn wrote:
> > > +	clkspec.np = np;
> > > +	clkspec.args_count = 1;
> > > +	clkspec.args[0] = 1;
> > > +
> > > +	priv.cpu_clk = of_clk_get_from_provider(&clkspec);
> > 
> > Oh, yet another way to get clocks...
> 
> Yep. I didn't like it, but could not find a better way.  It has been
> argued that cpufreq drivers should not have nodes in DT. So the normal
> of_clk_get() does not work. Since the clocks themselves are
> instantiated from DT, there are no clkdev alias, so plain clk_get()
> also does not work.
> 
But you should have a cpu node in DT, and it will be perfectly fine to
have cpu node consume that core_clk.

Shawn
