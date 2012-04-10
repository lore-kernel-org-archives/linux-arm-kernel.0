From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Apr 2012 15:30:55 +0100
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120410143055.GT24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 03:45:14PM +0200, Sascha Hauer wrote:
> With the generic clock framework we do not necessarily have
> a pointer to the struct clk we want to register a lookup
> for, so add a const char *clkname field to struct clk_lookup
> so that a lookup can be registered with a clock name.

All this silly names all over the place is getting to be utterly
rediculous. Why do we need to name clocks and look them up by name
when we have a perfectly good way (clkdev) to do this already?  Yes,
it takes a struct clk pointer but that's exactly because that's what
it has to return.

Why do we want to have another idiotic string to look up a clock which
is named using an idiotic scheme to find out its pointer to only then
register that with clkdev?

I think this clk stuff has gone totally insane wrt names recently.
