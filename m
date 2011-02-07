From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 7 Feb 2011 16:08:40 +0800
Subject: [RFC,
	PATCH 3/3] clk: add warnings for incorrect enable/prepare semantics
In-Reply-To: <20110207080555.GC27982@pengutronix.de>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1297058877.800990.238556019385.3.gpush@pororo>
	<20110207080555.GC27982@pengutronix.de>
Message-ID: <201102071608.42855.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

> This implies the warning is only issued on clocks that have a prepare
> callback.  If we want to enforce the new API the warning here shouldn't
> depend on clk->ops->prepare.  (clk_prepare and clk_unprepare need to
> be changed then to adapt the prepare_count even in the absence of
> clk->ops->prepare.)

Yeah, it's a decision about either adding a small cost to all clk_prepare()s 
(ie, adding cost when there is no prepare callback), or checking for the 
correct prepare/enable semantics for all clocks (even when it doesn't matter 
for that particular clock). I chose the first as more important, but happy to 
go either way here.

Cheers,


Jeremy
