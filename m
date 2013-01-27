From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Jan 2013 18:23:58 +0100
Subject: [PATCH v3 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <20130127171111.GG23505@n2100.arm.linux.org.uk>
References: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
 <1359281244-31455-2-git-send-email-andrew@lunn.ch>
 <20130127171111.GG23505@n2100.arm.linux.org.uk>
Message-ID: <20130127172358.GM29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	clkspec.np = np;
> > +	clkspec.args_count = 1;
> > +	clkspec.args[0] = 1;
> > +
> > +	priv.cpu_clk = of_clk_get_from_provider(&clkspec);
> 
> Oh, yet another way to get clocks...

Yep. I didn't like it, but could not find a better way.  It has been
argued that cpufreq drivers should not have nodes in DT. So the normal
of_clk_get() does not work. Since the clocks themselves are
instantiated from DT, there are no clkdev alias, so plain clk_get()
also does not work.

Do you know of a better way to do this?

   Thanks
	Andrew
