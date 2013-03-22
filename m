From: davidb@codeaurora.org (David Brown)
Date: Fri, 22 Mar 2013 10:47:22 -0700
Subject: [PATCH 0/3] Fix msm timer clearing bugs
In-Reply-To: <1363318299-10814-1-git-send-email-sboyd@codeaurora.org> (Stephen
 Boyd's message of "Thu, 14 Mar 2013 20:31:36 -0700")
References: <1363318299-10814-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <8ya4ng3ba39.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> Patches are based on v3.9-rc2. These patches will conflict with
> my other patch series to remove the local timer API, but the
> conflict isn't impossible to resolve and we can figure out how to
> deal with that after review.
>
> Patch 1 is a bug fix which could probably go into 3.9 if desired.
> Patch 2 overhauls the DT binding to be cleaner, and patch 3 fixes
> a bug where we don't wait for the timer to be clear before
> programming it leading to no more ticks.
>
> Stephen Boyd (3):
>   ARM: msm: Stop counting before reprogramming clockevent
>   ARM: msm: Rework timer binding to be more general
>   ARM: msm: Wait for timer clear to complete
>
>  .../devicetree/bindings/arm/msm/timer.txt          |  41 ++++----
>  arch/arm/boot/dts/msm8660-surf.dts                 |  20 ++--
>  arch/arm/boot/dts/msm8960-cdp.dts                  |  22 ++--
>  arch/arm/mach-msm/timer.c                          | 115 ++++++++++-----------
>  4 files changed, 90 insertions(+), 108 deletions(-)

I've pulled these into msm for/next, so the conflicts will probably show
up soon.

David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
