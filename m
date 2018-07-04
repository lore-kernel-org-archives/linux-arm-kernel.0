From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jul 2018 15:00:34 +0100
Subject: [PATCH v2 0/7] arm64: numa/topology/smp: update the cpumasks for
 CPU hotplug
In-Reply-To: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
References: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180704140034.GC4828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Mon, Jun 18, 2018 at 02:18:36PM +0100, Sudeep Holla wrote:
> was reported to cause some hotplug and system suspend regressions when
> it was merged. On investigation, it was found that unlike x86/PPC,
> arm64 doesn't update the cpu and numa masks on CPU hotplug. That's
> somewhat expected from the scheduler.
> 
> Since these changes were bit invasive as a solution to the above
> mentioned regression, as small change was temporarily applied as a fix.
> This series updates the cpu and numa masks on CPU hotplug and reverts
> that temporary fix.
> 
> It would be good to get this tested(CPU hotplug - few and all CPUs in
> a socket) on multi-socket/NUMA systems from Cavium and Huawei/Hisilicon.

This is looking pretty good to me. I've made some minor comments on a couple
of the patches, so please address those and repost with the Tested-bys that
you received, then I can queue this for 4.19.

Thanks,

Will
