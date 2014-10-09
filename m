From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 08 Oct 2014 18:32:32 -0700
Subject: [PATCH v2 0/8] Per-user clock constraints
In-Reply-To: <1412695334-2608-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1412695334-2608-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <5435E5B0.90900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2014 08:21 AM, Tomeu Vizoso wrote:
> Hello,
>
> this second version of the series adds several cleanups that were suggested by
> Stephen Boyd and contains several improvements to the seventh patch (clk: Make
> clk API return per-user struct clk instances) that were suggested by him during
> the review of v1.
>
> The first six patches are just cleanups that should be desirable on their own,
> and that should make easier to review the actual per-user clock patch.
>
> The seventh patch actually moves the per-clock data that was stored in struct
> clk to a new struct clk_core and adds references to it from both struct clk and
> struct clk_hw. struct clk is now ready to contain information that is specific
> to a given clk consumer.
>
> The eighth patch adds API for setting floor and ceiling constraints and stores
> that information on the per-user struct clk, which is iterable from struct
> clk_core.
>
>

As said in the patches, can you please indicate which baseline this is 
on? Also can you rebase onto clk-next if you send again before that is 
merged into 3.18-rc1? There are some changes in the debugfs part that 
will conflict. I'll review the more complicated parts in detail soon.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
