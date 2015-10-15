From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 17:12:07 +0200
Subject: [PATCH RESEND] drivers/perf: arm_pmu: avoid CPU device_node
 reference leak
In-Reply-To: <1444657719-3801-1-git-send-email-will.deacon@arm.com>
References: <1444657719-3801-1-git-send-email-will.deacon@arm.com>
Message-ID: <5085234.zfhqA4e0WO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 October 2015 14:48:39 Will Deacon wrote:
> of_cpu_device_node_get increments the reference count on the CPU
> device_node, so we must take care to of_node_put once we've finished
> with it.
> 
> This patch fixes the perf IRQ probing code to avoid the leak.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> 
> Arnd/Olof: Please can you take this via arm-soc? It's a non-urgent, yet
>            simple fix and I don't have any other fixes queued for perf.
> 

Seems still appropriate for 4.3, so I've put it into the fixes branch.
Thanks for the reminder,

	Arnd
