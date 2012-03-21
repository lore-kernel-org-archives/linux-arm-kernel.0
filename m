From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Mar 2012 09:07:31 +0000
Subject: [PATCH 1/2] clk: Fix error handling in fixed clock hardware
 type register fn
In-Reply-To: <CAJOA=zNteC+24oWpqkQJRnL8oqAJe2NcsjHNLbJb1MGN--VEsw@mail.gmail.com>
References: <CAJOA=zN2cSSpM92oRnW0RyU_ZzyoQ=jthc-fAkf-P3z37uWt7w@mail.gmail.com>
 <1332214706-675-1-git-send-email-skannan@codeaurora.org>
 <20120320071957.GH3852@pengutronix.de>
 <348585ed29fb3ff171267c03658e6c0d.squirrel@www.codeaurora.org>
 <CAJOA=zO=wp9oyuBZONk2oCRYdWU1c4qanKJik-8-sFg51p27MQ@mail.gmail.com>
 <4F693DD8.7070305@codeaurora.org>
 <CAJOA=zNteC+24oWpqkQJRnL8oqAJe2NcsjHNLbJb1MGN--VEsw@mail.gmail.com>
Message-ID: <20120321090730.GR15988@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 10:45:36PM -0700, Turquette, Mike wrote:
> IIRC, that discussion was with respect to the .parent member of struct
> clk.  It was decided that having .parent = NULL does not imply that a
> clock is a root clock, but instead we rely on the CLK_IS_ROOT flag.  I
> can't think of any other instance where a NULL clk when returned from
> a registration function would be useful.

No.  What I've been saying is that in _drivers_ which use clk_get(),
the error range is defined by IS_ERR(clk).  Every other value of
clk must be assumed by the driver to be valid, no ifs or buts.

What the clk API assumes about struct clk is its own business.  If it
wishes to interpret the NULL clk in a specific way, that's its business
to do so.  But it's still not the drivers business to then go and
interpret NULL as being any different from any other valid clock.

This is part of the clk API contract, which is as I said in the first
paragraph, and I keep on saying.  I'm not sure what's so difficult
about this.
