From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Apr 2012 10:26:15 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <20120413091712.GE27730@b20223-02.ap.freescale.net>
References: <20120411092034.GV24211@n2100.arm.linux.org.uk>
 <20120411094231.GO3852@pengutronix.de>
 <20120411094704.GY24211@n2100.arm.linux.org.uk> <4F879E9D.2090502@st.com>
 <CAAQ0ZWQ-ERDtCgEL9hJysX+-pW-K1O315t9PWoc1RMidLPpppg@mail.gmail.com>
 <4F87B443.6090405@st.com>
 <CAAQ0ZWR3-TvFjV3CX5oW+bUN6aW7ip5NphuKycq3twks2RrpMg@mail.gmail.com>
 <20120413085901.GG3168@opensource.wolfsonmicro.com> <4F87ED74.8020308@st.com>
 <20120413091712.GE27730@b20223-02.ap.freescale.net>
Message-ID: <20120413092615.GH24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 05:17:13PM +0800, Richard Zhao wrote:
> On Fri, Apr 13, 2012 at 02:40:12PM +0530, Viresh Kumar wrote:
> > On 4/13/2012 2:29 PM, Mark Brown wrote:
> > > Or we need to dump the arguments into a struct.
> > 
> > Then we would end up creating too many structures in our mach/clock.c
> > files. That will look bad. May perform better. :)
> or pass struct clk_lookup* ? For non-leaf clks, it's NULL.

What's wrong with the struct clk returned from clk_register() - why
not do this as a two-step process?  Especially as you may want to
associate a single clock with more than one clk_lookup.
