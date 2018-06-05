From: avanbrunt@nvidia.com (Alexander Van Brunt)
Date: Tue, 5 Jun 2018 17:07:54 +0000
Subject: [PATCH] arm64: alternative:flush cache with unpatched code
In-Reply-To: <20180605165511.GB2193@arm.com>
References: <1527617488-5693-1-git-send-email-rokhanna@nvidia.com>
 <20180530090044.GA2452@arm.com> <1527788750049.85185@nvidia.com>
 <20180604091609.GD9482@arm.com>
 <1528140881044.41145@nvidia.com>,<20180605165511.GB2193@arm.com>
Message-ID: <1528218506299.33619@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 1. Boot. This happens once, and we end up putting *all* secondary cores into
>    a tight loop anyway, so I don't see that the performance of
>    __flush_icache_all is relevant

Native boot happens once. But, each VM that boots will slow down all of the other VM's on the system. A VM boot can happen thousands of times.

I really don't want to cause the whole system to hiccup for a millisecond or more when there are only a few cache lines that need to be invalidated.
