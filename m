From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 Mar 2015 11:51:45 +0100
Subject: a question about run-time patching for heterogeneous cores.
In-Reply-To: <551A0402.90903@nvidia.com>
References: <551A0402.90903@nvidia.com>
Message-ID: <20150331105145.GB17653@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 31, 2015 at 03:18:42AM +0100, Bo Yan wrote:
> 
> The current code for arm64 run-time patching works fine if all CPUs are 
> the same, but doesn't seem to handle the case when CPUs are of different 
> type. For example, when you have a mix of A53 and A57 cores, currently 
> the errata WARs can be applied irrespective of A53 or A57 since the code 
> in need of patching are shared.
> 
> It doesn't look like the current WARs will cause functional problems 
> across different CPU cores. On the other hand, is there a perf issue due 
> to the same errata WARs being applied to different cores?

There may be some cost in an unaffected core executing the workaround
code, though this is very dependent on the particular CPU and
workaround, and in some cases the cost may not be measurable.

Where possible we attempt to use workarounds which are not excessively
expensive on particular cores in common pairings.

Thanks,
Mark.
