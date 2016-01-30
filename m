From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Jan 2016 17:16:41 -0800
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <1454107764-19876-1-git-send-email-stefan@agner.ch>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
Message-ID: <20160130011641.GD4848@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29, Stefan Agner wrote:
> If a clock gets enabled early during boot time, it can lead to a PLL
> startup. The wait_lock function makes sure that the PLL is really
> stareted up before it gets used. However, the function sleeps which
> leads to scheduling and an error:
> bad: scheduling from the idle thread!
> ...

Can you please share the full splat? I have no clue what's going
on.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
