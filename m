From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Dec 2012 15:32:01 +0530
Subject: [RFC PATCH 1/5] ARM: remove useless guard in smp.c
In-Reply-To: <1355832418-31692-2-git-send-email-mark.rutland@arm.com>
References: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
 <1355832418-31692-2-git-send-email-mark.rutland@arm.com>
Message-ID: <50D43399.7010705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 December 2012 05:36 PM, Mark Rutland wrote:
> Currently we only provide an implementation of smp_timer_broadcast in
> smp.c if GENERIC_CLOCKEVENTS_BROADCAST is selected. As
> smp_timer_broadcast is only used in smp.c, smp.c depends on SMP, and
> GENERIC_CLOCKEVENTS_BROADCAST is selected by SMP, this is unnecessary.
>
> This patch removes the redundant guard.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST isn't mandatory to
have SMP kernel working so the below select in ARM arch
kconfig not seems to entirely accurate. SMP kernel will
still boot with !GENERIC_CLOCKEVENTS_BROADCAST.

select GENERIC_CLOCKEVENTS_BROADCAST if SMP

The issue comes only for deeper CPU power C-states.
Anyway, you patch is correct from the current code point of
view.

Regards
Santosh
