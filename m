From: pmladek@suse.com (Petr Mladek)
Date: Tue, 30 Aug 2016 17:46:41 +0200
Subject: [PATCH v9 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
In-Reply-To: <1472487169-14923-5-git-send-email-cmetcalf@mellanox.com>
References: <1472487169-14923-1-git-send-email-cmetcalf@mellanox.com>
 <1472487169-14923-5-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20160830154641.GD4554@pathway.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-08-29 12:12:49, Chris Metcalf wrote:
> When doing an nmi backtrace of many cores, most of which are idle,
> the output is a little overwhelming and very uninformative.  Suppress
> messages for cpus that are idling when they are interrupted and just
> emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".
> 
> We do this by grouping all the cpuidle code together into a new
> .cpuidle.text section, and then checking the address of the
> interrupted PC to see if it lies within that section.
> 
> This commit suitably tags x86 and tile idle routines, and only
> adds in the minimal framework for other architectures.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org> [arm]
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>

This version works even with my configuration. Feel free to
add

Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
