From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 16 Nov 2015 15:48:22 +0000
Subject: arm64 function_graph tracer panic with CONFIG_DYNAMIC_FTRACE
In-Reply-To: <20151116134518.GC6556@e104818-lin.cambridge.arm.com>
References: <20151112104243.GF5627@e104818-lin.cambridge.arm.com>
 <56457A4B.601@linaro.org> <564937E3.3090501@linaro.org>
 <20151116134518.GC6556@e104818-lin.cambridge.arm.com>
Message-ID: <20151116154822.GA19228@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 01:45:19PM +0000, Catalin Marinas wrote:

[...]

> > There are some other functions which are called by cpu_suspend(), e.g. psci_system_suspend().
> > Should we apply a similar fix to them?
> 
> I think we need to apply the fix to any function which does not return.
> In general, this should apply to all finishers passed to cpu_suspend()
> and the subsequent callees.

Yes, I prefer Steven's suggestion though it seems to me the issue
is only related to the graph tracer and by pausing/resuming tracing
across cpu_suspend() we would solve the problem without having to
patch the finishers (and we can still trace them with the function
tracer).

Takahiro, do you want me to send a patch or you update yours ?

> Do we need such annotation for cpu_die() as well? It probably doesn't
> matter as the CPU is coming back on a completely different path anyway.

I will test this too in the process.

Thanks for debugging this,
Lorenzo
