From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 15 Feb 2011 10:00:28 +0800
Subject: [RFC,
	PATCH 3/3] clk: add warnings for incorrect enable/prepare semantics
In-Reply-To: <20110210093756.GA24710@b20223-02.ap.freescale.net>
References: <1297233693.241680.897691111624.0.gpush@pororo>
	<1297233693.243373.411051105619.3.gpush@pororo>
	<20110210093756.GA24710@b20223-02.ap.freescale.net>
Message-ID: <201102151000.29385.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

> >  void clk_unprepare(struct clk *clk)
> >  {
> > 
> > +	WARN_ON(clk->enable_count != 0);
> > +
> 
> Other drivers may be using the clock and increased the enable_count.
> This check may be moved to where we actually do unprepare.

Of course, thanks. Will update the series.


Jeremy
