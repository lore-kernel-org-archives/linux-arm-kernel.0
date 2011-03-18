From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 18 Mar 2011 18:15:26 +0100
Subject: [PATCH v2 4/9] lpc2k: generic time and clockevents
In-Reply-To: <20110318152012.GM29758@n2100.arm.linux.org.uk>
References: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300461116-6028-5-git-send-email-ithamar.adema@team-embedded.nl>
	<20110318152012.GM29758@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F80B15C9BD57@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> 
> On Fri, Mar 18, 2011 at 04:11:51PM +0100, Ithamar R. Adema wrote:
> > +	clk = clk_get(NULL, "timer1");
> > +	BUG_ON(IS_ERR(clk));

I didn't see a specific enable for timer0, it seems to work for me
because my boot loader leaves it on when booting the kernel, but
maybe it's also needed.


> > +
> > +	clk_enable(clk);
> > +	rate = clk_get_rate(clk);
> > +	clk_put(clk);
> 
> Don't put a clock that you continue to use.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
