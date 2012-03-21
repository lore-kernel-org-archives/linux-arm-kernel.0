From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 20 Mar 2012 23:33:05 -0700 (PDT)
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
Message-ID: <82f47abcdd341a5071f8c0a178d52310.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, March 20, 2012 10:45 pm, Turquette, Mike wrote:
> IIRC, that discussion was with respect to the .parent member of struct
> clk.  It was decided that having .parent = NULL does not imply that a
> clock is a root clock, but instead we rely on the CLK_IS_ROOT flag.  I
> can't think of any other instance where a NULL clk when returned from
> a registration function would be useful.

I wasn't referring to a discussion with regards to this patch series. I'm
referring to what I believe was a discussion with Russell King on whether
a NULL from clk_get() should be considered a clock and whether it should
be usable as a "clock" with the clock APIs. That's the reason clk_get()
returns -ENOENT instead of NULL.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
