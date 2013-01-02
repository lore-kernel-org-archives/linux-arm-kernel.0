From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 Jan 2013 12:05:17 -0700
Subject: [PATCH V3 0/5] ARM: tegra20: cpuidle: add power-down state
In-Reply-To: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
Message-ID: <50E484ED.90108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 07:30 PM, Joseph Lo wrote:
> This adds a "powered-down" state in cpuidle for Tegra20. It requires power
> gating both CPU cores. When the CPU1 requests to enter "powered-down"
> state, it saves its own state and then enters WFI. When the CPU0 requests
> the same state, it attempts to put the CPU1 into reset to prevent it from
> waking up. Then power down both CPUs together and turn off the CPU rail.
> 
> If the CPU1 be woken up before CPU0 entering powered-down state, then it
> needs to restore it's CPU state and waits for next chance.

Joseph,

What's the status of this series? It looks like there are quite a few
comments on V3; I assume you'll post a new version to address those.
Will you base the new version on top of Prashant's common clock cleanup
to remove the conflicts with that?
