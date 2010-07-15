From: skannan@codeaurora.org (Saravana Kannan)
Date: Wed, 14 Jul 2010 23:27:16 -0700
Subject: Meaning of clk_round_rate()?
In-Reply-To: <20100714200324.GA18138@n2100.arm.linux.org.uk>
References: <4C3DFC7A.8020002@codeaurora.org>
	<20100714200324.GA18138@n2100.arm.linux.org.uk>
Message-ID: <4C3EAA44.7040607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Jul 14, 2010 at 11:05:46AM -0700, Stephen Boyd wrote:
> clk_round_rate() returns the clock rate which will be set if you ask
> clk_set_rate() to set that rate.  It provides a way to query from
> the implementation exactly what rate you'll get if you use clk_set_rate()
> with that same argument.

Fair enough explanation for clk_round_rate(). I guess I should take it 
as "it's up to the specific clock implementation on what it wants to do".

But what about the problem of a clock consumer trying to find a suitable 
frequency amongst the ones provided by a particular clock?

What are your thoughts on adding the following two APIs to linux/clk.h?
clk_round_rate_down/floor()
clk_round_rate_up/ceil()

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
