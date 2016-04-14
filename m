From: atomlin@redhat.com (Aaron Tomlin)
Date: Thu, 14 Apr 2016 16:17:05 +0100
Subject: [PATCH v5 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <1459877208-15119-2-git-send-email-cmetcalf@mellanox.com>
References: <1459877208-15119-1-git-send-email-cmetcalf@mellanox.com>
 <1459877208-15119-2-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20160414151705.GE20425@atomlin.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2016-04-05 13:26 -0400, Chris Metcalf wrote:
> Currently you can only request a backtrace of either all cpus, or
> all cpus but yourself.  It can also be helpful to request a remote
> backtrace of a single cpu, and since we want that, the logical
> extension is to support a cpumask as the underlying primitive.
> 
> This change modifies the existing lib/nmi_backtrace.c code to take
> a cpumask as its basic primitive, and modifies the linux/nmi.h code
> to use either the old "all/all_but_self" arch methods, or the new
> "cpumask" method, depending on which is available.
> 
> The existing clients of nmi_backtrace (arm and x86) are converted
> to using the new cpumask approach in this change.
> 
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
> ---
>  arch/arm/include/asm/irq.h    |  4 +--
>  arch/arm/kernel/smp.c         |  4 +--
>  arch/x86/include/asm/irq.h    |  4 +--
>  arch/x86/kernel/apic/hw_nmi.c |  6 ++---
>  include/linux/nmi.h           | 63 ++++++++++++++++++++++++++++++++++---------
>  lib/nmi_backtrace.c           | 15 +++++------
>  6 files changed, 65 insertions(+), 31 deletions(-)

Looks good to me.

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin
