From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 23 Sep 2014 13:59:50 -0700
Subject: [PATCH v13 0/9] Per-user clock constraints
In-Reply-To: <1411497613-24049-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1411497613-24049-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <5421DF46.2010107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/14 11:40, Tomeu Vizoso wrote:
> Hello,
>
> this version of the patchset addresses some issues that Russell pointed out
> yesterday:
>
> * Refactor the changes to clkdev.c to reduce the amount of ifdefs.
>
> * Properly release clocks when there isn't enough memory to create the per-user
> wrapper.
>
> * Add clk_provider_put(struct clk_core*) for clock implementations to call
> instead of clk_put(struct clk*) (instead of exposing __clk_put).
>
> As the previous versions, this is based on top of 3.17-rc4 and Mike's patch at
> [0].

Any thoughts on my comments on patch set #10[1]? It seems like we can
avoid having a flag day to support this.

[1] https://lkml.org/lkml/2014/9/9/960

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
