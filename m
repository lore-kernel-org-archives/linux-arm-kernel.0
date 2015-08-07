From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 07 Aug 2015 09:46:37 +0200
Subject: [PATCH 2/3] nvmem: imx-ocotp: Add i.MX6 OCOTP driver
In-Reply-To: <55C3B74F.5010501@linaro.org>
References: <1438693342-605-1-git-send-email-p.zabel@pengutronix.de>
 <1438693342-605-2-git-send-email-p.zabel@pengutronix.de>
 <55C38941.9090709@linaro.org> <1438878490.3223.10.camel@pengutronix.de>
 <55C3B74F.5010501@linaro.org>
Message-ID: <1438933597.3638.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 06.08.2015, 20:36 +0100 schrieb Srinivas Kandagatla:
> Hi Philipp,
> 
> Could you add Greg KH in the CC, for next merge window, we can request 
> Greg to take this driver via his tree.
> 
> Once the comments are fixed you can add my
> 
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> On 06/08/15 17:28, Philipp Zabel wrote:
> > Hi Srinivas,
> >
> > Am Donnerstag, den 06.08.2015, 17:20 +0100 schrieb Srinivas Kandagatla:
> >> Few Nits..
> >>
> >> On 04/08/15 14:02, Philipp Zabel wrote:
> >>> +#include <linux/clk.h>
> >> May be you can drop this?
> >
> > Yes, that's a left-over and can be removed.
> >
> >> BTW, who is taking care of the gated peripheral clock controlled for
> >> this driver?
> >
> > Nobody. I had initially copied the code that actually senses the fuses,
> > but since this happens during power-on reset anyway (all values are
> > stored in shadow registers), I didn't see the point and dropped it for
> > now.
> > The shadow registers are clocked directly by the ungated ipg_root clock.
> 
> So, are you planning to drop the clocks property from the bindings too?

The gated clock input exists and is needed for the full functionality of
the device (writing and re-sensing fuses). It should be in the device
tree even if the linux driver doesn't implement writing.

regards
Philipp
