From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Jan 2016 00:31:12 -0800
Subject: [PATCH v4 03/13] clk: at91: remove IRQ handling and use polling
In-Reply-To: <1453911072-23608-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1453911072-23608-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160128083112.GJ12841@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27, Alexandre Belloni wrote:
> The AT91 clock drivers make use of IRQs to avoid polling when waiting for
> some clocks to be enabled. Unfortunately, this leads to a crash when those
> IRQs are threaded (which happens when using preempt-rt) because they are
> registered before thread creation is possible.
> 
> Use polling on those clocks instead to avoid the problem.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
