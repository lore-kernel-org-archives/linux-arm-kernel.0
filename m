From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Jul 2010 20:37:05 -0700
Subject: Meaning of clk_round_rate()?
In-Reply-To: <20100714200324.GA18138@n2100.arm.linux.org.uk>
References: <4C3DFC7A.8020002@codeaurora.org>
	<20100714200324.GA18138@n2100.arm.linux.org.uk>
Message-ID: <4C3E8261.60307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  On 07/14/2010 01:03 PM, Russell King - ARM Linux wrote:
> clk_round_rate() returns the clock rate which will be set if you ask
> clk_set_rate() to set that rate.  It provides a way to query from
> the implementation exactly what rate you'll get if you use clk_set_rate()
> with that same argument.
>
> So essentially, clk_set_rate() should be:
>
> static int clk_set_rate(struct clk *clk, unsigned long rate)
> {
> 	rate = clk_round_rate(clk, rate);
> 	return set_actual_rate(clk, rate);
> }

 From what I understand, you're saying clk_round_rate() is defined as 
what clk_set_rate() would do, which is call clk_round_rate() and then 
set the rate with whatever is returned by clk_round_rate()? Isn't that a 
recursive definition?

I'll play along though. The use of the function is to determine what the 
rate will be if I call clk_set_rate(), but what is the implementation of 
it suppose to be. I guess now I'm asking what should clk_set_rate() do? 
Round up, down, to the closest value, or just fail if it's not exact.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
