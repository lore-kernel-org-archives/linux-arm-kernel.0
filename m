From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 18:00:53 -0700
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <1454107764-19876-1-git-send-email-stefan@agner.ch>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
Message-ID: <20160416010052.GR26353@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29, Stefan Agner wrote:
> If a clock gets enabled early during boot time, it can lead to a PLL
> startup. The wait_lock function makes sure that the PLL is really
> stareted up before it gets used. However, the function sleeps which
> leads to scheduling and an error:
> bad: scheduling from the idle thread!
> ...
> 
> Use udelay in case IRQ's are still disabled.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

This is really old. Shawn, are you picking these up? I'm removing
these from my queue for now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
