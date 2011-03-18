From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Fri, 18 Mar 2011 16:44:25 +0100
Subject: [PATCH v2 4/9] lpc2k: generic time and clockevents
In-Reply-To: <20110318152012.GM29758@n2100.arm.linux.org.uk>
References: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300461116-6028-5-git-send-email-ithamar.adema@team-embedded.nl>
	<20110318152012.GM29758@n2100.arm.linux.org.uk>
Message-ID: <1300463065.2138.147.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-03-18 at 15:20 +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 18, 2011 at 04:11:51PM +0100, Ithamar R. Adema wrote:
> > +	clk = clk_get(NULL, "timer1");
> > +	BUG_ON(IS_ERR(clk));
> > +
> > +	clk_enable(clk);
> > +	rate = clk_get_rate(clk);
> > +	clk_put(clk);
> 
> Don't put a clock that you continue to use.

Ok, will remove the clk_put() here then.

Regards,

Ithamar.
