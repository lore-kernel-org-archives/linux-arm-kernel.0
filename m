From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 May 2015 12:45:12 -0700
Subject: Automatic clock disabling on clk_put()
In-Reply-To: <20150513064550.GE28888@pengutronix.de>
References: <20150511060129.GG6325@pengutronix.de>
 <55528B84.5050700@codeaurora.org> <20150513064550.GE28888@pengutronix.de>
Message-ID: <5553A9C8.2070701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/15 23:45, Uwe Kleine-K?nig wrote:
>
>> that hard to call clk_disable_unprepare() on a clock at the end of an
>> error path? Maybe you could add a devm_clk_get_prepare_enable() that
>> does what you want and then call clk_disable_unprepare on the exit path?
> You mean clk_disable_unprepare is called in the same function that calls
> clk_put I assume such that you don't have to do anything in the exit
> path.
>

Yes that's what I mean.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
