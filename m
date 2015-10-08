From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Oct 2015 14:58:40 -0700
Subject: [PATCH 1/3] clk: add flag for clocks that need to be enabled on
 rate changes
In-Reply-To: <3137165.kmu68gRS44@diego>
References: <1929669.AsgMSusdJb@phil>
 <3137165.kmu68gRS44@diego>
Message-ID: <20151008215840.GJ26883@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02, Heiko St?bner wrote:
> Hi,
> 
> any comment on these 3 patches?
> 

Dong has a similar problem, but those patches conflate this with
enabling parent clocks during clk_disable_unused() which makes no
sense to me. So I'm ok with the requirement that we turn clocks
on to change rates, but I wonder if in this case we need to turn
on the clock that's changing rates itself, or if we just need to
turn on the parent and/or future parent of the clock during the
rate switch. Care to elaborate on that?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
