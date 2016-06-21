From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Jun 2016 11:24:13 +0200
Subject: [PATCH v2 04/15] clk: sunxi-ng: Add fixed factor clock support
In-Reply-To: <20160621011537.GP1521@codeaurora.org>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160607204154.31967-5-maxime.ripard@free-electrons.com>
 <20160621011537.GP1521@codeaurora.org>
Message-ID: <20160621092413.GP26668@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, Jun 20, 2016 at 06:15:37PM -0700, Stephen Boyd wrote:
> On 06/07, Maxime Ripard wrote:
> > +
> > +#include <linux/clk-provider.h>
> > +
> > +#include "ccu_common.h"
> > +
> > +struct ccu_fixed_factor {
> > +	u16			div;
> > +	u16			mult;
> > +
> > +	struct ccu_common	common;
> 
> Does this use the common structure although we have no usage for
> the members of struct ccu_common except struct clk_hw? I suppose
> this is done so registering a bunch of clks is easy?

Yes, when we discussed this with Mike back at the ELC, he said that he
really liked the approach you had the qualcomm clocks where you have a
single array with all the clocks, so I tried to follow that as much as
possible.

Even though it doesn't really make much sense here, indeed.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160621/89926c4e/attachment-0001.sig>
