From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 5 Apr 2016 22:59:51 -0600
Subject: [PATCH 4/4] irqchip: bcm2836: Use a more generic memory barrier
 call
In-Reply-To: <1459827858-3871-5-git-send-email-eric@anholt.net>
References: <1459827858-3871-1-git-send-email-eric@anholt.net>
 <1459827858-3871-5-git-send-email-eric@anholt.net>
Message-ID: <570497C7.10501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2016 09:44 PM, Eric Anholt wrote:
> dsb() requires an argument on arm64, so we needed to add "sy".
> Instead, take this opportunity to switch to the same smp_wmb() call
> that gic uses for its IPIs.  This is a less strong barrier than we
> were doing before (dmb(ishst) compared to dsb(sy)), but it seems to be
> the correct one.

I assume all MMIO is part of the ish domain?

If so, the series,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
