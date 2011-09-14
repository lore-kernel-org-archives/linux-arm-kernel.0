From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 14 Sep 2011 10:41:36 +0100
Subject: [PATCH 01/11] clk: Add a generic clock infrastructure
In-Reply-To: <decbd6943536eae1bddda9765ac5b267.squirrel@www.codeaurora.org>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<decbd6943536eae1bddda9765ac5b267.squirrel@www.codeaurora.org>
Message-ID: <20110914094135.GA2909@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2011 at 07:22:17PM -0700, Saravana Kannan wrote:
> On Wed, August 24, 2011 6:15 am, Mark Brown wrote:

> > -struct clk;
> > +static inline int clk_prepare(struct clk *clk) { return 0; }
> > +static inline void clk_unprepare(struct clk *clk) { }

> You should add might_sleep() inside these stubs. That way, if any device
> driver developers wants to move over to the new APIs before their arch
> does, they get to see the warnings when they call prepare/unprepare in
> atomic context.

Just to repeat previous clarifications as I said when I reposted I've no
intention of working on this, I'm just republishing Jeremy's work as
Mike needed a copy.
