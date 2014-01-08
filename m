From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 8 Jan 2014 18:30:06 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1389201013-23794-1-git-send-email-broonie@kernel.org>
References: <1389201013-23794-1-git-send-email-broonie@kernel.org>
Message-ID: <20140108183006.GC9724@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 05:10:10PM +0000, Mark Brown wrote:

[...]

> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> new file mode 100644
> index 000000000000..853544f30a8b
> --- /dev/null
> +++ b/arch/arm64/kernel/topology.c
> @@ -0,0 +1,92 @@
> +/*
> + * arch/arm64/kernel/topology.c
> + *
> + * Copyright (C) 2011,2013 Linaro Limited.
> + *
> + * Based on the arm32 version written by Vincent Guittot in turn based on
> + * arch/sh/kernel/topology.c
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/init.h>
> +#include <linux/percpu.h>
> +#include <linux/node.h>
> +#include <linux/nodemask.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>

Nitpick, <linux/slab.h> does not belong in this patch. There are other
includes that should be moved to the respective patch (percpu.h ?) where
they are actually used.

Lorenzo
