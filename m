From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 31 Oct 2012 14:24:41 -0600
Subject: [PATCH V4 0/7] ARM: tegra30: cpuidle: add a powered-down state
In-Reply-To: <1351676481-28425-1-git-send-email-josephl@nvidia.com>
References: <1351676481-28425-1-git-send-email-josephl@nvidia.com>
Message-ID: <50918909.60100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2012 03:41 AM, Joseph Lo wrote:
> This adds a "powered-down" state for cpuidle. It's a power gating idle
> mode. It supports the secondary CPUs (i.e., CPU1-CPU3) to go into
> powered-down state independently. When any of the secondary CPUs go into
> this state, it can be power gated alone. There is a limitation on CPU0.
> The CPU0 can go into powered-down state only when all secondary CPU is
> offline. After CPU0 is in powered-down state, the CPU rail can be turned
> off.
> 
> All CPUs entering powered-down state is not working. The CPU0 enters this
> state only when secondary CPU is offline. This can be coverd by CPUquiet
> and cluster switching mechanism.

OK, this appears to work OK. I have applied it to Tegra's
for-3.8/cpuidle branch.

> V4:
> * rebased on next-20121031

Purely as an FYI, being based on top of Tegra's for-3.8/cpuidle or
for-next branches would have been even better, although in practice this
time around, there were no conflicts applying it there.
