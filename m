From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 3 Jan 2013 16:39:36 +0800
Subject: [PATCH V3 0/5] ARM: tegra20: cpuidle: add power-down state
In-Reply-To: <50E484ED.90108@wwwdotorg.org>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
 <50E484ED.90108@wwwdotorg.org>
Message-ID: <1357202376.3594.37.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-01-03 at 03:05 +0800, Stephen Warren wrote:
> On 12/17/2012 07:30 PM, Joseph Lo wrote:
> > This adds a "powered-down" state in cpuidle for Tegra20. It requires power
> > gating both CPU cores. When the CPU1 requests to enter "powered-down"
> > state, it saves its own state and then enters WFI. When the CPU0 requests
> > the same state, it attempts to put the CPU1 into reset to prevent it from
> > waking up. Then power down both CPUs together and turn off the CPU rail.
> > 
> > If the CPU1 be woken up before CPU0 entering powered-down state, then it
> > needs to restore it's CPU state and waits for next chance.
> 
> Joseph,
> 
> What's the status of this series? It looks like there are quite a few
> comments on V3; I assume you'll post a new version to address those.
> Will you base the new version on top of Prashant's common clock cleanup
> to remove the conflicts with that?
> 

Yes, I will re-base on top of Prashant's CCF rework in the next version.
But there are some issues, I am co-working with Prashant to make sure
every thing is work as usual. Will re-post this series later after
everything be settled down.

Thanks,
Joseph
