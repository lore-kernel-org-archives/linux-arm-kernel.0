From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 03 May 2011 10:38:32 -0700
Subject: [RFC PATCH 08/12] ARM: msm: use remapped PPI interrupts for local
	timer
In-Reply-To: <1304439338.27148.186.camel@e102391-lin.cambridge.arm.com>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>	
	<1303326501-15664-9-git-send-email-marc.zyngier@arm.com>	
	<4DB6FD50.9070907@codeaurora.org>
	<1304439338.27148.186.camel@e102391-lin.cambridge.arm.com>
Message-ID: <4DC03D98.8090502@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2011 09:15 AM, Marc Zyngier wrote:
>
> Thanks for having a look at all of this. I think the lack of an MSM
> platform shows here... Can I fold your patches into mine?

Sure, just leave out this hunk:

-       if (!local_clock_event) {
-               writel(0, clock->regbase  + TIMER_ENABLE);
-               writel(0, clock->regbase + TIMER_CLEAR);
-               writel(~0, clock->regbase + TIMER_MATCH_VAL);
-       }


and add a bool or something to make sure these lines don't get executed
more than once. Hopefully you get the idea.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
