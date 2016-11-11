From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Nov 2016 11:18:31 +0000
Subject: [PATCH v4 1/5] arm64: perf: Basic uncore counter support for
 Cavium ThunderX SOC
In-Reply-To: <20161111103921.GE16907@hardcore>
References: <cover.1477741719.git.jglauber@cavium.com>
 <73173d6ad2430eead5e9da40564a90a60961b6d9.1477741719.git.jglauber@cavium.com>
 <20161110165405.GH4418@leverpostej>
 <20161111103921.GE16907@hardcore>
Message-ID: <20161111111830.GA11945@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 11:39:21AM +0100, Jan Glauber wrote:
> Hi Mark,
> 
> thanks for reviewing. One question below,

> On Thu, Nov 10, 2016 at 04:54:06PM +0000, Mark Rutland wrote:

> > On Sat, Oct 29, 2016 at 01:55:29PM +0200, Jan Glauber wrote:

> > > +#include <linux/cpufeature.h>
> > > +#include <linux/numa.h>
> > > +#include <linux/slab.h>
> > 
> > I believe the following includes are necessary for APIs and/or data
> > explicitly referenced by the driver code:

[...]

> Should I also add includes that are already in the included by uncore_cavium.h?

Please do.

> I usually avoid includes that come through the "local" header file.

Generally, when you explcitly use some macro/function/data in a file,
that file should have the relevant include. 

If something's only used in the header (e.g. hidden in a macro or inline
function), then we only need that include in the header.

For example: uncore_cavium.h uses container_of(), and should include
<linux/kernel.h>. Also, uncore_cavium.c also uses container_of()
directly for something unrelated, and should also include
<linux/kernel.h>.

Thanks,
Mark.
