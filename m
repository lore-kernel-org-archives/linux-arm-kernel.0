From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 May 2014 18:37:27 +0100
Subject: [PATCH 1/2] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <1400545421-28067-1-git-send-email-broonie@kernel.org>
References: <1400545421-28067-1-git-send-email-broonie@kernel.org>
Message-ID: <20140520173727.GD28293@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 01:23:40AM +0100, Mark Brown wrote:
> In heterogeneous systems like big.LITTLE systems the scheduler will be
> able to make better use of the available cores if we provide power numbers
> to it indicating their relative performance. Do this by parsing the CPU
> nodes in the DT.

Last time we discussed these two patches, my understanding was that the
mainline scheduler doesn't behave any better on big.LITTLE with this
additional information, unless you also have additional out of tree b.L
MP patches. Vincent is also cleaning up some of the cpu_power usage in
the scheduler.

So unless there are clear benefits in providing such information to the
mainline scheduler, I don't plan to merge them for the time being (I'm
also not convinced of the numbers in the second patch, they need some
benchmarking on real hardware).

-- 
Catalin
