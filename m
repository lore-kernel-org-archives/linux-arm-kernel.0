From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 06 Aug 2015 18:28:10 +0200
Subject: [PATCH 2/3] nvmem: imx-ocotp: Add i.MX6 OCOTP driver
In-Reply-To: <55C38941.9090709@linaro.org>
References: <1438693342-605-1-git-send-email-p.zabel@pengutronix.de>
 <1438693342-605-2-git-send-email-p.zabel@pengutronix.de>
 <55C38941.9090709@linaro.org>
Message-ID: <1438878490.3223.10.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

Am Donnerstag, den 06.08.2015, 17:20 +0100 schrieb Srinivas Kandagatla:
> Few Nits..
> 
> On 04/08/15 14:02, Philipp Zabel wrote:
> > +#include <linux/clk.h>
> May be you can drop this?

Yes, that's a left-over and can be removed.

> BTW, who is taking care of the gated peripheral clock controlled for 
> this driver?

Nobody. I had initially copied the code that actually senses the fuses,
but since this happens during power-on reset anyway (all values are
stored in shadow registers), I didn't see the point and dropped it for
now.
The shadow registers are clocked directly by the ungated ipg_root clock.

[...]
> > +MODULE_LICENSE("GPL");
> 
> GPL v2 ?

Will do.

thanks
Philipp
