From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Jan 2013 10:22:27 -0700
Subject: [PATCH V4 0/5] ARM: tegra20: cpuidle: add power-down state
In-Reply-To: <1358323807-30157-1-git-send-email-josephl@nvidia.com>
References: <1358323807-30157-1-git-send-email-josephl@nvidia.com>
Message-ID: <51001C53.1030609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 01:10 AM, Joseph Lo wrote:
> This adds a "powered-down" state in cpuidle for Tegra20. It requires power
> gating both CPU cores. When the CPU1 requests to enter "powered-down"
> state, it saves its own state and then enters WFI. When the CPU0 requests
> the same state, it attempts to put the CPU1 into reset to prevent it from
> waking up. Then power down both CPUs together and turn off the CPU rail.
> 
> If the CPU1 be woken up before CPU0 entering powered-down state, then it
> needs to restore it's CPU state and waits for next chance.

I have applied this series to Tegra's for-3.9/soc branch.
