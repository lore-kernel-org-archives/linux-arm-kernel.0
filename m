From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 22 Jul 2014 10:12:03 +0100
Subject: [PATCH v6 3/7] arm64: kernel: introduce cpu_init_idle CPU
 operation
In-Reply-To: <53CD9A53.5070001@codeaurora.org>
References: <1405958786-17243-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1405958786-17243-4-git-send-email-lorenzo.pieralisi@arm.com>
 <53CD9A53.5070001@codeaurora.org>
Message-ID: <20140722091203.GB8511@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 11:55:15PM +0100, Stephen Boyd wrote:
> On 07/21/14 09:06, Lorenzo Pieralisi wrote:
> > diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> > new file mode 100644
> > index 0000000..46eb3ea
> > --- /dev/null
> > +++ b/arch/arm64/kernel/cpuidle.c
> > @@ -0,0 +1,27 @@
> > +/*
> > + * ARM64 CPU idle arch support
> > + *
> > + * Copyright (C) 2014 ARM Ltd.
> > + * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <asm/cpu_ops.h>
> > +
> > +int cpu_init_idle(unsigned int cpu)
> 
> sparse will probably complain here unless we include <asm/cpuidle.h> right?

Yes, I missed that, now fixed, thanks a lot.

Lorenzo
