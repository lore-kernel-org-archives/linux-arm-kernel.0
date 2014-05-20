From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 20 May 2014 17:31:39 -0400 (EDT)
Subject: [PATCH 1/2] arm64: topology: Tell the scheduler about the relative
 power of cores
In-Reply-To: <20140520173727.GD28293@arm.com>
References: <1400545421-28067-1-git-send-email-broonie@kernel.org>
 <20140520173727.GD28293@arm.com>
Message-ID: <alpine.LFD.2.11.1405201716460.17310@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 May 2014, Catalin Marinas wrote:

> On Tue, May 20, 2014 at 01:23:40AM +0100, Mark Brown wrote:
> > In heterogeneous systems like big.LITTLE systems the scheduler will be
> > able to make better use of the available cores if we provide power numbers
> > to it indicating their relative performance. Do this by parsing the CPU
> > nodes in the DT.
> 
> Last time we discussed these two patches, my understanding was that the
> mainline scheduler doesn't behave any better on big.LITTLE with this
> additional information, unless you also have additional out of tree b.L
> MP patches. Vincent is also cleaning up some of the cpu_power usage in
> the scheduler.
> 
> So unless there are clear benefits in providing such information to the
> mainline scheduler, I don't plan to merge them for the time being (I'm
> also not convinced of the numbers in the second patch, they need some
> benchmarking on real hardware).

We are indeed in the process of working out how to use this information 
in the scheduler, submitting patches, etc.  Thing is, we risk seeing the 
scheduler maintainers saying: "unless there are clear users of those 
enhancements to the mainline scheduler, we don't plan to merge them for 
the time being."

It might be more productive to merge _something_ first, and doing so on 
the architecture side is certainly the least intrusive initial move.

As to the numbers themselves... I suspect it will be hard to come up 
with a benchmark that everyone will agree with.  Those numbers certainly 
can be refined later when the scheduler side has evolved and more tests 
have been performed.


Nicolas
