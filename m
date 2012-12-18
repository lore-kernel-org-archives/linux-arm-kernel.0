From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Dec 2012 10:47:09 -0800
Subject: [RFC PATCH 1/5] ARM: remove useless guard in smp.c
In-Reply-To: <1355832418-31692-2-git-send-email-mark.rutland@arm.com>
References: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
 <1355832418-31692-2-git-send-email-mark.rutland@arm.com>
Message-ID: <50D0BA2D.2020600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/12 04:06, Mark Rutland wrote:
> Currently we only provide an implementation of smp_timer_broadcast in
> smp.c if GENERIC_CLOCKEVENTS_BROADCAST is selected. As
> smp_timer_broadcast is only used in smp.c, smp.c depends on SMP, and
> GENERIC_CLOCKEVENTS_BROADCAST is selected by SMP, this is unnecessary.

You might want to add that GENERIC_CLOCKEVENTS_BROADCAST depends on
GENERIC_CLOCKEVENTS and SMP depends on GENERIC_CLOCKEVENTS too.

> This patch removes the redundant guard.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
